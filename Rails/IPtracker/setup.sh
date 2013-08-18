echo "MIGRATING"
bundle exec rake db:migrate
echo "RESET DB"
bundle exec rake db:reset
echo "POPULATE DB"
bundle exec rake db:populate
echo "PREPARE TEST"
bundle exec rake test:prepare