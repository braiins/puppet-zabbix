# == Class: zabbix
#
# Basic zabbix setup of the package repository
#
# === Parameters
#
# Document parameters here.
#
# [*version*]
#   Version of zabbix
#
# === Examples
#
#  class { 'zabbix': }
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class zabbix($version = $zabbix::params::version,
             $manage_package_repo = $zabbix::params::manage_package_repo
) inherits zabbix::params {

  if $manage_package_repo {
    apt::source { 'zabbix':
      location   => "http://repo.zabbix.com/zabbix/${version}/debian",
      repos      => 'main',
      key        => '79EA5ED4',
      key_server => 'keys.gnupg.net',
    }
  }
}
