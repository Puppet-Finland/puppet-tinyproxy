#
# == Class: tinyproxy::params
#
# Defines some variables based on the operating system
#
class tinyproxy::params {

    include ::os::params

    case $::osfamily {
        'Debian': {
            $package_name = 'tinyproxy'
            $config_name = '/etc/tinyproxy.conf'
            $service_name = 'tinyproxy'
            $pidfile = '/var/run/tinyproxy/tinyproxy.pid'
        }
        default: {
            fail("Unsupported operating system ${::osfamily}")
        }
    }

    if $::systemd {
        $service_start = "${::os::params::systemctl} start ${service_name}"
        $service_stop = "${::os::params::systemctl} stop ${service_name}"
    } else {
        $service_start = "${::os::params::service_cmd} ${service_name} start"
        $service_stop = "${::os::params::service_cmd} ${service_name} stop"
    }
}
