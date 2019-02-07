#!/bin/bash
#pg_snap_remove $1
pg_snap_create $1 192.168.2.51
#lxc exec u16pg-replica-$1 -- /bin/bash -c "cd /etc/postgresql/9.6/main; mc"
lxc exec u16pg-replica-$1  -- tail -f /var/log/postgresql/postgresql-9.6-main.log

