#!/bin/bash -x

set -e

env

whoami

id

sudo /etc/init.d/dbus start

#### -----------------------------------------------------------------------
#### 2.A) As Root User -- Choose this or 2.B --####
#### ---- Use this when running Root user ---- ####
/bin/bash -c "$*"

#### 2.B) As Non-Root User -- Choose this or 2.A  ---- #### 
#### ---- Use this when running Non-Root user ---- ####
#### ---- Use gosu (or su-exec) to drop to a non-root user
#exec gosu ${NON_ROOT_USER} "$@"
#### -----------------------------------------------------------------------

tail -f /dev/null
