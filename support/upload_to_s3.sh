#!/bin/bash

cd /var/games/minecraft/archive/HOTELBRAGANCA.CLUB
echo $(ls -t1 | grep tgz | head -n 1)
ls -t1 | grep tgz | head -n 1 | xargs -I % curl -X PUT -T % 	https://s3.eu-central-1.amazonaws.com/hbc-mc-backups/ -o ~/last_upload_result.out
ls -t1 | grep tgz | head -n 1 | xargs -I % echo "uploaded to s3" > %
