#!/bin/bash

snapshots='pg96-gifts-replica-L4'
containers='u16pg-replica-L4'

#эту функцию надо добавить в проверку на удаление уже замонтированных сенпшотов 
function check_taken_date()
{
usedsnaps=`lxc list --fast | grep RUNNING | grep u16pg-replica-h | awk -F '[|.]' '{print $2}' | cut -c16-`
}


for snapshot in $snapshots
do
  todelete=`zfs list -t snap | grep "z5z2ssd/pgReplica/"$snapshot | grep "hourly" | sort  | awk '{print $1}' | head -n -96`
  if [ ! -z "$todelete" ]; then
    delsnap=(${todelete// / })
    for snap in ${delsnap[@]}
      do
        #zfs release lockholder $snap
        zfs destroy $snap
        #echo "delete "$snap
      done
  fi
done

for snapshot in $snapshots
do
  todelete=`zfs list -t snap | grep "z5z2ssd/pgReplica/"$snapshot | grep "dayli" | sort  | awk '{print $1}' | head -n -7`
  if [ ! -z "$todelete" ]; then
    delsnap=(${todelete// / })
    for snap in ${delsnap[@]}
      do
        #zfs release lockholder $snap
        zfs destroy $snap
        #echo "delete "$snap
      done
  fi
done


for container in $containers
do
  todelete=`zfs list -t snap | grep "z5z2ssd/lxd/containers/"$container | sort  | awk '{print $1}' | grep "hourly" | head -n -96`
  if [ ! -z "$todelete" ]; then
    delsnap=(${todelete// / })
    for snap in ${delsnap[@]}
      do
        #zfs release lockholder $snap
        #lxc delete u16pg-replica-L4/$snap
        snap=`echo $snap | awk -F '[@]' '{print $2}' | cut -c10-`
        lxc delete u16pg-replica-L4/$snap
      done
  fi
done

for container in $containers
do
  todelete=`zfs list -t snap | grep "z5z2ssd/lxd/containers/"$container | sort  | awk '{print $1}' | grep "dayli" | head -n -7`
  if [ ! -z "$todelete" ]; then
    delsnap=(${todelete// / })
    for snap in ${delsnap[@]}
      do
        #zfs release lockholder $snap
        #lxc delete u16pg-replica-L4/$snap
        snap=`echo $snap | awk -F '[@]' '{print $2}' | cut -c10-`
        lxc delete u16pg-replica-L4/$snap
      done
  fi
done


