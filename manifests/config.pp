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

) inherits tinyproxy::params
{

    if $listen_address == 'all' {
        $listen_line = undef
    } else {
        $listen_line = "Listen ${listen_address}"
    }

    file { 'tinyproxy-tinyproxy.conf':
        ensure  => present,
        name    => $::tinyproxy::params::config_name,
        content => template('tinyproxy/tinyproxy.conf.erb'),
        owner   => $::os::params::adminuser,
        group   => $::os::params::admingroup,
        mode    => '0644',
        require => Class['tinyproxy::install'],
        notify  => Class['tinyproxy::service'],
    }
}
