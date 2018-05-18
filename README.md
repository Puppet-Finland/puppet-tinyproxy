# tinyproxy

A Puppet module for managing tinyproxy. Includes optional monit and firewall support. 

# Module usage

To setup tinyproxy:

    class { '::tinyproxy':
      listen_address     => '10.170.5.15',
      port               => '8888',
      allow_address_ipv4 => '10.0.0.0/8',
    }

For details see [init.pp](manifests/init.pp).
