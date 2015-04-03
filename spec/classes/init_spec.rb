require 'spec_helper'
describe 'blackfire' do

  context 'with defaults for all parameters' do
    it { should compile }
    it { should contain_class('blackfire') }
  end
end
