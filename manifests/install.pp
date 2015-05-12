#
# == Class: tinyproxy::install
#
# Install tinyproxy
#
class tinyproxy::install inherits tinyproxy::params {

    package { 'tinyproxy':
        ensure => present,
        name   => $::tinyproxy::params::package_name,
    }
}
