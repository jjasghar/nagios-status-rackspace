nagios-status-rackspace
=======================

I created some nagios scripts to check https://status.rackspace.com. It seems they don't have an RSS feed or anything and i wanted a proactive way of getting notifications.

It's basicly just curl and sed, but it does the trick. PRs and suggestions are more than welcome.

Installation
------------

Pre: Be sure `curl` in installed. On the box you want to run it from

In your `commands.cfg` put something like:
```
define command {
   command_name check-rackspace-1st-gen
   command_line /usr/lib/nagios/plugins/cloud_servers_1st
}

define command {
    command_name check-rackspace-next-gen
    command_line /usr/lib/nagios/plugins/cloud_servers_next_chicago
}

define command {
    command_name check-rackspace-rackconnect
    command_line /usr/lib/nagios/plugins/rackconnect_chicago
}
```
This will check against the Cloud Servers (First Generation) overall, the Chicago Cloud Servers (Next Generation) specific and Rackconnect Chicago specific.  

In your `services.cfg` add something like this:
```
define service {
    service_description Rackspace 1st Gen status
    use default-service
    host nagios
    check_command  check-rackspace-1st-gen
}

define service {
    service_description Rackspace Next Gen Chicago status
    use default-service
    host nagios
    check_command  check-rackspace-next-gen
}

define service {
    service_description Rackspace Rackconnect Chicago
    use default-service
    host nagios
    check_command  check-rackspace-rackconnect
}
```
Make sure you change the host to whatever host you want to run this from.  I suggest your actual nagios box or localhost.

Put the scripts in the location you want to run them from, this example `/usr/lib/nagios/plugins/` and I rename them without the `.sh`, and don't forget tho `chmod +x` them.

Restart nagios and you should see them started polling.
