require 'spec_helper_acceptance'

describe 'blackfire::agent class' do

  describe 'running puppet code' do

    it 'make sure we have copied the module' do
      # binding.pry
      shell("ls #{default['distmoduledir']}/blackfire/metadata.json", {:acceptable_exit_codes => 0})
    end

    it 'should work with no errors' do
      pp = <<-EOS
        class { 'blackfire':
          server_id => 'foo',
          server_token => 'bar',
          agent => {
              service_ensure => 'stopped',
          },
        }
      EOS

      # Apply twice to ensure no errors the second time.
      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to match(/error/i)
      end
      apply_manifest(pp, :catch_failures => true) do |r|
        expect(r.stderr).not_to eq(/error/i)
        expect(r.exit_code).to be_zero
      end
    end

    describe file('/etc/blackfire/agent') do
      it { should be_file }
      its(:content) { should match 'server-id=foo' }
      its(:content) { should match 'server-token=bar' }
    end

    describe service('blackfire-agent') do
      it { should be_enabled }
    end

  end
end
