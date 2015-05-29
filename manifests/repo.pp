# Manages the repository
class blackfire::repo inherits blackfire {

  if $::blackfire::manage_repo == true {
    case $::osfamily {
      'debian': {
        if !defined(Class['apt']) {
          class { 'apt': }
        }

        if defined('apt::setting') {
        # apt >= 2.0
          apt::source { 'blackfire':
            location => 'http://packages.blackfire.io/debian',
            release  => 'any',
            repos    => 'main',
            key      => {
              source => 'https://packagecloud.io/gpg.key',
              id     => '418A7F2FB0E1E6E7EABF6FE8C2E73424D59097AB',
            },
          }
          Exec['apt_update'] -> Package <||>
        } else {
          # apt >= 1.x
          apt::source { 'blackfire':
            location    => 'http://packages.blackfire.io/debian',
            release     => 'any',
            repos       => 'main',
            key         => 'D59097AB',
            key_source  => 'https://packagecloud.io/gpg.key',
            include_src => false,
          }
        }
      }
      'redhat': {
        yumrepo { 'blackfire':
          descr     => 'blackfire',
          baseurl   => 'http://packages.blackfire.io/fedora/$releasever/$basearch',
          gpgcheck  => 0,
          enabled   => 1,
          gpgkey    => 'https://packagecloud.io/gpg.key',
          sslverify => 'True',
          sslcacert => '/etc/pki/tls/certs/ca-bundle.crt',
        }
      }
      default: {
        fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
      }
    }
  }

}
