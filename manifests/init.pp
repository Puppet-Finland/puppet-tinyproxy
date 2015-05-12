#
# == Class: tinyproxy
#
# Setup tinyproxy - a simple http/https proxy server
#
# == Parameters
#
# [*manage*]
#   Manage tinyproxy using Puppet. Valid values are 'yes' (default) and 'no'.
# [*listen_address*]
#   A single IP address to bind to. Special value 'all' (default) binds to all 
#   available interfaces. 
# [*port*]
#   The TCP port to listen on. Defaults to 8888.
# [*allow_address_ipv4*]
#   IPv4 address or address range to allow connections from. Defaults to 
#   '127.0.0.1'.
# [*allow_address_ipv6*]
#   IPv4 address or address range to allow connections from. Defaults to '::1'.
# [*monitor_email*]
#   Email address where local service monitoring software sends it's reports to. 
#   Defaults to global variable $::servermonitor.
#
# == Examples
#
# include tinyproxy
#
# == Authors
#
# Samuli Seppänen <samuli@openvpn.net>
#
# == License
#
# BSD-lisence
# See file LICENSE for details
#
class tinyproxy
(
    $manage = 'yes',
    $listen_address = 'all',
    $port = 8888,
    $allow_address_ipv4 = '127.0.0.1',
    $allow_address_ipv6 = '::1',
    $monitor_email = $::servermonitor
)
{

if $manage == 'yes' {

    include ::tinyproxy::install

    class { '::tinyproxy::config':
        listen_address     => $listen_address,
        port               => $port,
        allow_address_ipv4 => $allow_address_ipv4,
    }

    include ::tinyproxy::service

    if tagged('monit') {
        class { '::tinyproxy::monit':
            monitor_email => $monitor_email,
        }
    }

    if tagged('packetfilter') {

        class { '::tinyproxy::packetfilter':
            allow_address_ipv4 => $allow_address_ipv4,
            allow_address_ipv6 => $allow_address_ipv6,
            port               => $port,
        }
    }
}
}
