#
# == Class: tinyproxy::service
#
# Configures tinyproxy to start on boot
#
class tinyproxy::service inherits tinyproxy::params {

    service { 'tinyproxy':
        name    => $::tinyproxy::params::service_name,
        enable  => true,
        require => Class['tinyproxy::install'],
    }
}
