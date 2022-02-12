# AWS Tools

The tools here are for devops on AWS.

`lib/` are helper classes/functions for putting scripts together.  Each script
is given full controll of what its supposed to do in one function.  That is,
we're not trying to make reusable modules/classes.

### build-uat

Build UAT as if it were already running.  This allows us to not keep systems
running on AWS but just prove/confirm our deployment strategy.  Running this
should give you the network, cluster, db (migrated up to master).  It should
allow for multiple networks (pass in a tag name)


### build-prod

Should be the same as build-uat with a different name.

### build-demo

Single public network to put stand-alone demo branches on

### build-private

NOT IN USE
Multi private subnet (w/NAT) + public subnet ... possible vpn access 
