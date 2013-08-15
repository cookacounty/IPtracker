namespace :iptracker do
  desc "IPtracker | Setup production application"
  task setup: :environment do
    setup_db
  end

  def setup_db

    #unless ENV['force'] == 'yes'
    #  puts "This will create the necessary database tables and seed the database."
    #  puts "You will lose any previous data stored in the database."
    #  ask_to_continue
    #  puts ""
    #end

    Rake::Task["db:reset"].invoke
    Rake::Task["db:populate"].invoke
    Rake::Task["test:prepare"].invoke
    
  #rescue IPtracker::TaskAbortedByUserError
  #  puts "Quitting...".red
  #  exit 1
  #end
  end
end