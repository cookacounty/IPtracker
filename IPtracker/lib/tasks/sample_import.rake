 require 'debugger'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    
    #Read an example cds file
    include CdsimportHelper
    example_file_name = "IPtrackerParsed.txt"
    read_example_cdsfile(example_file_name)
    
    make_celltracker
    
  end
end

def read_example_cdsfile(example_file_name)
  
  filePath =  Rails.root.join('public', 'example_import', example_file_name)
  foutPath =  Rails.root.join('public', 'example_import', example_file_name+".parsed")
  
  fin_read = File.read(filePath)
  dsc = "1780AA"
  cdsin_parser(dsc,fin_read,foutPath)
  
end

def make_celltracker
  users = User.all
  cells = Cdscell.all
  user  = users.first
  
  tracked_cells = cells[1..5]
  tracked_cells.each { |cell| user.track!(cell) }
end

#---DEPRICATED ----


