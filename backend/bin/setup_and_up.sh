#!/bin/sh -e
bundle exec rails db:reset db:migrate
rm -f ./tmp/pids/*
rails s -p 3000 -b '0.0.0.0'"
