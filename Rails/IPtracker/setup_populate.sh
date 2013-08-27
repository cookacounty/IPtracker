echo "RESET DB"
bundle exec rake db:reset
echo "POPULATE DB"
bundle exec rake db:populate
