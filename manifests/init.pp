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
    # Note for 'release' apt::source's attribute:
    # Specifies a distribution of the Apt repository. Default: "$lsbdistcodename".
    # Default is usually fine.
    # Here, for Zabbix, there is no build of version 2.2 for Jessie in the official repo,
    # so we hardcode 'wheezy' value in such case (the package is pretty installable)
    if ($version == '2.2') and ($lsbdistcodename == 'jessie') {
      $release = 'wheezy'
    } else {
      $release = $lsbdistcodename
    }

    apt::source { 'zabbix':
      location   => "http://repo.zabbix.com/zabbix/${version}/debian",
      repos      => 'main',
      release    => $release,
      key        => $version ? {
        default => 'FBABD5FB20255ECAB22EE194D13D58E479EA5ED4',
        '3.2'   => 'A1848F5352D022B9471D83D0082AB56BA14FE591',
      },
      key_server => 'pgp.mit.edu',
    }
  }
}
