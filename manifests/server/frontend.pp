# == Class: zabbix::server::frontend
#
# Zabbix server frontend
#
# === Parameters
#
# Document parameters here.
#
#
# === Examples
#
#  class { 'zabbix::server::frontend':
#  }
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class zabbix::server::frontend (
  $server_name,
  $host,
  $listen_port,
  $db_host,
  $db_name,
  $db_user,
  $db_password,
) inherits zabbix::server::params {

  $db_type = 'POSTGRESQL'
  package { 'php5-pgsql':
    ensure => present,
  } ->
  package { 'zabbix-frontend-php':
    ensure  => present,
    require => Service[$service_name],
  } ->
  file { '/etc/zabbix/web/zabbix.conf.php':
    ensure => present,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0640',
    content => template('zabbix/zabbix.conf.php.erb'),
    #notify  => Service[$service_name],
  }
}
