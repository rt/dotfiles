
## Services / Jobs

Check things out with a runlevel, ex. rc3.d/, where everything is linked to /etc/init.d/script.  Many of those are now linked to /lib/init/upstart-job.
Last script run is /etc/rc.local.  Further up the chain is /etc/network/if-up.d/, /etc/udev/rules.d/, /etc/X11/Xsession.d/.  Some of them will emit upstart events where /etc/init/ scripts will catch.

#### Upstart

	$initctl list

	$initctl stop myjob

	#know all jobs that start at boot
	$grep "start on" /etc/init/*

	$vi /etc/init/myjob.conf

	$man upstart-events

##### Own Upstart Job

	exec /bin/foo args

	or,

	script
		if[...]; then
		fi
	end script

