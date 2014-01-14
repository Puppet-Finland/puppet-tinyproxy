#
# == Class: tinyproxy::install
#
# Install tinyproxy
#
class tinyproxy::install {

    include tinyproxy::params

    package { 'tinyproxy':
        name => "${::tinyproxy::params::package_name}",
        ensure => present,
    }
}
