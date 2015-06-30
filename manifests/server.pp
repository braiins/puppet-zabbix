# == Class: zabbix
#
# Zabbix server setup
#
# === Parameters
#
# Document parameters here.
#
#
# === Examples
#
#  class { 'zabbix::server': }
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class zabbix::server (
  $listen_port              = '10051',
  $sourceip                 = undef,
  $log_file                 = '/var/log/zabbix/zabbix_server.log',
  $log_filesize             = undef,
  $debug_level              = '3',
  $pid_file                 = '/var/run/zabbix/zabbix_server.pid',
  $db_host                  = 'localhost',
  $db_name                  = 'zabbix',
  $db_user                  = 'zabbix',
  $db_password,
  $start_pollers            = '5',
  $start_ipmipollers        = '0',
  $start_pollersunreachable = '1',
  $start_trappers           = '5',
  $start_pingers            = '1',
  $start_discoverers        = '1',
  $start_httppollers        = '1',
  $listen_ip                = undef,
  $housekeeping_frequency   = '1',
  $max_housekeeperdelete    = '500',
  $sender_frequency         = '30',
  $cache_size               = '8M',
  $cache_updatefrequency    = '60',
  $start_dbsyncers          = '4',
  $history_cachesize        = '8M',
  $trend_cachesize          = '4M',
  $history_textcachesize    = '16M',
  $timeout                  = '5',
  $trapper_timeout          = '300',
  $unreachable_period       = '45',
  $unavailable_delay        = '60',
  $alert_scriptspath        = undef,
  $external_scripts_path    = undef,
  $fping_location           = '/usr/bin/fping',
  $fping6_location          = '/usr/bin/fping6',
) inherits zabbix::server::params {

  # user that owns the configuration files
  $zabbix_user = 'zabbix'

  # preseed doesn't work completely, database admin password needs to
  # be set manually and db user name always defaults to 'zabbix'.
  $preseed_file = '/var/cache/debconf/zabbix-server-pgsql.preseed'
  file { $preseed_file:
    owner => root,
    group => root,
    mode => '0400',
    backup  => false,
    content => template('zabbix/server-pgsql.preseed.erb'),
  }

  package { $package_name:
    ensure       => installed,
    responsefile => $preseed_file,
    require      => [ File[$preseed_file] ],
  } ->
  postgresql::server::role { $db_user:
    password_hash => postgresql_password($db_user, $db_password),
  } ->
  service { $service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }

  file { '/etc/zabbix/zabbix_server.conf':
    ensure => present,
    owner  => $zabbix_user,
    group  => $zabbix_user,
    mode   => '0640',
    content => template('zabbix/zabbix_server.conf.erb'),
    notify  => Service[$service_name],
  }


}
