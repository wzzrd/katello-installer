# Katello Default Params
class katello::params {

  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'Fedora': {
          $scl_prefix = ''
          $scl_root = ''
        }
        default: {
          $scl_prefix = 'ruby193-'
          $scl_root = '/opt/rh/ruby193/root'
        }
      }

      $package_names = ['katello', "${scl_prefix}rubygem-katello"]
    }
    default: {
      fail("${::hostname}: This module does not support osfamily ${::osfamily}")
    }
  }

  $rhsm_url = '/rhsm'
  $deployment_url = '/katello'

  if file_exists('/usr/sbin/tomcat') and !file_exists('/usr/sbin/tomcat6') {
    $tomcat = 'tomcat'
  }
  else {
    $tomcat = 'tomcat6'
  }

  # HTTP Proxy settings (currently used by pulp)
  $proxy_url = undef
  $proxy_port = undef
  $proxy_username = undef
  $proxy_password = undef

  # cdn ssl settings
  $cdn_ssl_version = undef

  # system settings
  $user = 'foreman'
  $group = 'foreman'
  $user_groups = 'foreman'
  $config_dir  = '/etc/foreman/plugins'
  $log_dir     = '/var/log/foreman/plugins'

  # OAUTH settings
  $oauth_key = 'katello'
  $oauth_token_file = 'katello_oauth_secret'
  $oauth_secret = cache_data($oauth_token_file, random_password(32))

  $post_sync_token = cache_data('post_sync_token', random_password(32))

  # Subsystems settings
  $candlepin_url = 'https://localhost:8443/candlepin'
  $pulp_url      = "https://${::fqdn}/pulp/api/v2/"

  # database reinitialization flag
  $reset_data = 'NONE'

  $qpid_url = "amqp:ssl:${::fqdn}:5671"
  $candlepin_event_queue = 'katello_event_queue'
}
