# AWS

This will describe setting a typical server farm with a database in AWS.
- VPC (w/subnets?)
- Database
- App Servers
- Other ...

[PIC]

1. Do from console
2. Do with awscli (shell scripts)
3. Do with aws api (from admin in pebblefields.com)

### Setup

- create an account and create a IAM user / security group
- get aws cli (see ~/.aws for your creds etc)
-
-

### VPC

You VPC is you network in the cloud.
http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Subnets.html

Typical, you will create a vpc, subnet,  internet gateway, and route table.
Subnet's route table should point to the internet gateway, becoming a public subnet.
The internet gateway also provides NAT for instances that need to an ip externally (elastic IP)

The default VPC comes with all this automatically when you setup...

#### VPC's Security Group

Is the security group used to acces DBs and ECs in your VPC.

Often you'll create a group per access rule.  
Instances that needed ssh > port 22, web > port 80, 5432 > postgres

Security groups control inbound and outbound traffic for your instances, and network ACLs control inbound and outbound traffic for your subnets

| **Source**                      | **Protocol** | **Port Range** | **Note**                                                                                                                                                       |
| ----------                      | ----------   | ----------     | ----------                                                                                                                                                     |
| 0.0.0.0/0                       | TCP          | 80             | Allow HTTP access                                                                                                                                              |
| 0.0.0.0/0                       | TCP          | 443            | Allow HTTPS access                                                                                                                                             |
| Your network                    | TCP          | 22             | Allow SSH access from your network                                                                                                                             |
| Security group Id (sg-xxxxxxxx) | ALL          | ALL            | (optional) Allow from other instances associated with this security group.  This is added fro the default but you must add your own on custom security groups. |


### RDS

Can access through psql (must specify a db ie skeleton)
```
psql -h pebble.cy82mav2bmyb.us-west-2.rds.amazonaws.com -p 5433 -U pebble skeleton 
```
- aws rds describe-db-instances | grep Endpoint -C 10


To access from your local machine you need to add an inbound rule to the vpc security group (ie your external ip cidr port 5432)

