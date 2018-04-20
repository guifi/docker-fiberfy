#!/bin/bash
/user-mapping.sh
perl /fiberfy-entry.pl
/bin/bash -c "$*"
