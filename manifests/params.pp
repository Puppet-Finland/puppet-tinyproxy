#
# == Class: tinyproxy::params
#
# Defines some variables based on the operating system
#
class tinyproxy::params {

    case $::osfamily {
        'Debian': {
            $package_name = 'tinyproxy'
            $config_name = '/etc/tinyproxy.conf'
            $service_name = 'tinyproxy'
            $service_start = "/usr/sbin/service $service_name start"
            $service_stop = "/usr/sbin/service $service_name stop"
            $pidfile = '/var/run/tinyproxy/tinyproxy.pid'
        }
        default: {
            $package_name = 'tinyproxy'
            $config_name = '/etc/tinyproxy.conf'
            $service_name = 'tinyproxy'
            $service_start = "/usr/sbin/service $service_name start"
            $service_stop = "/usr/sbin/service $service_name stop"
            $pidfile = '/var/run/tinyproxy/tinyproxy.pid'
        }
    }
}
