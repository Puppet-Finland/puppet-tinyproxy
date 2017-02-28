#
# == Class tinyproxy::packetfilter
#
# Configures packetfiltering rules for tinyproxy
#
class tinyproxy::packetfilter
(
    $allow_address_ipv4,
    $allow_address_ipv6,
    $port

) inherits tinyproxy::params
{


    # IPv4 rules
    $source_v4 = $allow_address_ipv4 ? {
        'any'   => undef,
        default => $allow_address_ipv4,
    }

    @firewall { '009 ipv4 accept tinyproxy':
        provider => 'iptables',
        chain    => 'INPUT',
        proto    => 'tcp',
        source   => $source_v4,
        dport    => $port,
        action   => 'accept',
        tag      => 'default',
    }

    # IPv6 rules
    $source_v6 = $allow_address_ipv6 ? {
        'any'   => undef,
        default => $allow_address_ipv6,
    }

    @firewall { '009 ipv6 accept tinyproxy':
        provider => 'ip6tables',
        chain    => 'INPUT',
        proto    => 'tcp',
        source   => $source_v6,
        dport    => $port,
        action   => 'accept',
        tag      => 'default',
    }
}
