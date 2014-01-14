#
# == Class: tinyproxy::config
#
# Configure tinyproxy
#
class tinyproxy::config
(
    $listen_address,
    $port,
    $allow_address_ipv4,
)
{

    include tinyproxy::params

    if $listen_address == 'all' {
        $listen_line = ''
    } else {
        $listen_line = "Listen $listen_address"
    }

    file { 'tinyproxy-tinyproxy.conf':
        name => "${::tinyproxy::params::config_name}",
        ensure => present,
        content => template('tinyproxy/tinyproxy.conf.erb'),
        owner => root,
        group => root,
        mode => 644,
        require => Class['tinyproxy::install'],
        notify => Class['tinyproxy::service'],
    }
}
