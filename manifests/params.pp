# == Class: zabbix::params
#
# This class defines default parameters of the main zabbix class
#
#
# === Examples
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
# === Authors
#
# Braiins Systems s.r.o.
#
# === Copyright
#
# Copyright 2014 Braiins Systems s.r.o.
#
class zabbix::params {
  $version = '2.2'
  $manage_package_repo = true
}
