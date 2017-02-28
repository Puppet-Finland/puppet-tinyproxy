#
# == Class: tinyproxy::monit
#
# Setups monit rules for tinyproxy
#
class tinyproxy::monit
(
    $monitor_email
)
{
    @monit::fragment { 'tinyproxy-tinyproxy.monit':
        modulename => 'tinyproxy',
        basename   => 'tinyproxy',
        tag        => 'default',
    }
}
