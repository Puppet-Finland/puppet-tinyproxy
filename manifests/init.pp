#
# == Class: tinyproxy
#
# Setup tinyproxy - a simple http/https proxy server
#
# == Parameters
#
# [*manage*]
#   Manage tinyproxy using Puppet. Valid values are true (default) and false.
# [*manage_packetfilter*]
#   Manage packet filtering rules. Valid values are true (default) and false.
# [*manage_monit*]
#   Manage monit rules. Valid values are true (default) and false.
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
    Boolean $manage = true,
    Boolean $manage_packetfilter = true,
    Boolean $manage_monit = true,
            $listen_address = 'all',
            $port = 8888,
            $allow_address_ipv4 = '127.0.0.1',
            $allow_address_ipv6 = '::1',
            $monitor_email = $::servermonitor
)
{

if $manage {

    include ::tinyproxy::install

    class { '::tinyproxy::config':
        listen_address     => $listen_address,
        port               => $port,
        allow_address_ipv4 => $allow_address_ipv4,
    }

    include ::tinyproxy::service

    if $manage_monit {
        class { '::tinyproxy::monit':
            monitor_email => $monitor_email,
        }
    }

    if $manage_packetfilter {

        class { '::tinyproxy::packetfilter':
            allow_address_ipv4 => $allow_address_ipv4,
            allow_address_ipv6 => $allow_address_ipv6,
            port               => $port,
        }
    }
}
}
