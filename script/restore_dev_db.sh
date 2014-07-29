#!/bin/sh

# terminate script as soon as any command fails
set -e

echo 'Downloading dump file from production'
curl -o latest.dump `heroku pgbackups:url -a augustageorgia`

echo 'Dropping and recreating local DB schema'
bundle exec rake db:drop db:create

echo 'Restoring data into DB'
pg_restore --verbose --clean --no-acl --no-owner  --disable-triggers -U danubilla -d augusta_development latest.dump

echo 'Deleting dump file'
rm latest.dump
