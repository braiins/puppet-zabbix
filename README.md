# zabbix

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sentry](#setup)
	* [What sentry affects](#what-sentry-affects)
	* [Setup requirements](#setup-requirements)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module configures zabbix server with postgres backend. It has
been tested with puppet 3.7.x on Debian systems.

## Module Description

Zabbix is a strong system monitoring tool. This modules allows
deploying two major components:

* zabbix server + database backend on postgres
* zabbix web frontend

## Setup

### What zabbix affects

* the module deploys a new database with admin user (called 'zabbix')
  only if the specified database host points to localhost. Using a
  non-local backend assumes presence of an empty database.

### Setup Requirements

When postgres database has not been setup yet, the following deploys it:

	class { 'postgresql::globals':
	  encoding            => 'UTF8',
	  manage_package_repo => true,
	  version             => '9.3',
	}->
	class { 'postgresql::server':
	} ->
	postgresql::server::config_entry { 'check_function_bodies':
	 value => 'off',
	}

## Usage

The snippet below deploys basic zabbix server.

	 class { 'zabbix': } ->
	 class { 'zabbix::server':
	   require        => Class['postgresql::server'],
	 } ->
	 class { 'zabbix::server::frontend':
	   server_name    => 'zabbix-monitor',
	   host           => 'localhost',
	   listen_port    => $zabbix::server::listen_port,
	   db_host        => $zabbix::server::db_host,
	   db_name        => $zabbix::server::db_name,
	   db_user        => $zabbix::server::db_user,
	   require        => Class['postgresql::server'],
	 }


## Reference

Classes:
* [zabbix](#class-zabbix)
* [zabbix::server](#class-zabbixserver)
* [zabbix::server::params](#class-zabbixserverparams)
* [zabbix::server::frontend](#class-zabbixserverfrontend)
* [zabbix::server::frontend::params](#class-zabbixserverfrontendparams)

## Limitations

This module intentionally supports only postgres database.

## Development

Patches and improvements are welcome as pull requests for the central
project github repository.

## Contributors
