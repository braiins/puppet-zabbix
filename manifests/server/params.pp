# == Class: zabbix::server::params
#
# This class defines default parameters of the main zabbix class
#
#
# === Examples
#
# This class is not intended to be used directly. It may be imported
# or inherited by other classes
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class zabbix::server::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $service_name = 'zabbix-server'
      $package_name = 'zabbix-server-pgsql'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}
