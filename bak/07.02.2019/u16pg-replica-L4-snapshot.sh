#!/bin/bash

# take now date
date=`date +%Y-%m-%d-%H-%M`
container='u16pg-replica-L4'

# create hourly snapshot
/usr/bin/lxc snapshot $container "hourly-"$date &
zfs snapshot z5z2ssd/pgReplica/pg96-gifts-replica-L4@"hourly-"$date

# create daily snapshot on 00-00 everyday
hmtime=`date +%H-%M`
[ "$hmtime" == "00-00" ] && {
/usr/bin/lxc snapshot $container "daily-"$date &
zfs snapshot z5z2ssd/pgReplica/pg96-gifts-replica-L4@"daily-"$date
}





