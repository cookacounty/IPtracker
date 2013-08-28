require 'debugger'

namespace :test do
  desc "Fill database with sample data"
  task import: :environment do
    
    require 'IPimport'
    
    tmp_path = Rails.root.join('tmp', 'import')
    tmp_file = 'IPtracker.tar.gz'
    destination = Rails.root.join('public', 'import_test')
    
    myimport = IPimport.new(tmp_file,tmp_path,destination)
    myimport.untar
    
    
    myimport.move(1,"1780","ADC_COMP")
    
  end
  
  
end