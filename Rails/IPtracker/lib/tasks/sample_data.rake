 require 'debugger'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    #Read an example cds file
    include CdsimportHelper
    example_file_name = "IPtrackerParsed.txt"
    read_example_cdsfile(example_file_name)
    
    make_users
    make_microposts
    make_relationships
    
    #make_cdslibs
    #make_cdscells
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "example@railstutorial.org",
                       title:    Faker::Name.title,
                       password: "foobar",
                       password_confirmation: "foobar",
                       admin: true)
  99.times do |n|
    
    fakerName = Faker::Name
    name  = fakerName.name
    title = fakerName.title
    
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 title:    title,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def read_example_cdsfile(example_file_name)
  
  filePath =  Rails.root.join('public', 'example_import', example_file_name)
  foutPath =  Rails.root.join('public', 'example_import', example_file_name+".parsed")
  
  fin_read = File.read(filePath)
  
  cdsin_parser(fin_read,foutPath)
  
end


#---DEPRICATED ----

def make_cdslibs
  5.times do |n|
    
    fakerName = Faker::Company.name

    Cdslib.create!(name: fakerName)
  end
end

def make_cdscells
  cdslibs = Cdslib.all(limit: 6)
  10.times do
    fakerName = Faker::Name.name
    cdslibs.each { |cdslib| cdslib.cdscells.create!(name: fakerName) }
  end
end

