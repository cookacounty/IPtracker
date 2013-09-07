require 'IPimport'

module CdsimportHelper
  
  def validate_file(uploaded_io)
    
    if uploaded_io
      #Only allow the specially named file
      valid_file = File.basename(uploaded_io.original_filename) == Settings.iptracker.tar_file
    else
      valid_file = nil
    end
    
    return valid_file
    
  end
  
  def build_micropost(silicon)
        @micropost = current_user.microposts.build({content: "Imported libraries for dsc #{silicon}"})
        @micropost.save!
  end
  
  def parse_cds_file(silicon_name,uploaded_io)    
      
      
    tmp_path = Settings.iptracker.tmp_path
    
    #Location of the parsed cell file
    parsed_file = tmp_path+"/"+Settings.iptracker.parsed_file
    
    #Write the uploaded file to temporary path
    tar_file = tmp_path+"/"+Settings.iptracker.tar_file

    #Generate the Images
    importer = IPimport.new
    
    File.open(tar_file, 'wb') do |file|
      file.write(uploaded_io.read)
    end
          
    #Untar the tarball
    importer.untar    

    #Read the parsed file
    fin_read = File.open(parsed_file,"r")
          
    #Create or update the silicon
    silicon = cdsin_create_silicon(silicon_name)
    
    libRegex = /^\S\w+/ #first char is not white space
    cellRegex = /^\s+\w+.+/ #first char is white space
    
    lineNumber = 1
    headerLines = 1
    
    cdslib = nil
    
    fout_path = Settings.iptracker.import_log
    
    #Open the file, parse each line
    File.open(fout_path, 'w') do |fout|
      
      fin_read.each_line do |line|
        
        #Determine what the line is based on regex
        isLib  = line.match(libRegex)
        isCell = line.match(cellRegex)
        isSkip = lineNumber <= headerLines
        
        prefix = "#{lineNumber}:"
        case
          when isSkip
            fout.puts "#{prefix}SKIP"
          when isLib  
            name = isLib[0]
            cdslib = cdsin_create_lib(name)
            fout.puts "#{prefix}LIB #{name} references #{cdslib.name+' '+ cdslib.id.to_s}"
            
          when isCell
            lineSplit = isCell[0].split(' ')
            name = lineSplit[0]
            xsize = lineSplit[1]
            ysize = lineSplit[2]
            area  = lineSplit[3]

            cdscell = cdsin_create_cell(silicon,cdslib,name,xsize,ysize,area)
            celllib = cdscell.cdslib

            destination_path = importer.move(celllib.id,celllib.name,cdscell.name)
            
            cdscell.update_png_location(destination_path)
            
            fout.puts "#{prefix}CELL #{name} references #{destination_path}"
          else        
            fout.puts "#{prefix}NOTHING"
        end
        
        lineNumber += 1
      end

    end

  #Clean out the temp dir
  importer.cleanup

  end
  
  #Create the silicon/Update if it exists
  def cdsin_create_silicon(name)
    silicon = Silicon.find_by_name(name)
    
    if silicon
      silicon.touch(:updated_at)
    else
      silicon = Silicon.create!(name: name)
    end
      
    return silicon
  end
  
  #Create the library/Update if it exists
  def cdsin_create_lib(name)
    cdslib = Cdslib.find_by_name(name)
    
    if cdslib
      cdslib.touch(:updated_at)
    else
      cdslib = Cdslib.create!(name: name)
    end
      
    return cdslib
  end
  
  #Create the cell/Update if it exists
  def cdsin_create_cell(silicon,cdslib,name,xsize,ysize,area)
    
    cdscell = cdslib.cdscells.find_by(name: name)

    if cdscell
      cdscell.update!(xsize: xsize, ysize: ysize, area: area)
    else
      #create the cell
      cdscell = cdslib.cdscells.create!(name: name, xsize: xsize, ysize: ysize, area: area)
    end
    
    #categorize_cell(cdscell)
    
    cdscell.add_silicon!(silicon)
    
    return cdscell
  end
  
  #Categorize each cell with specified default 
  def categorize_cell(cdscell, category)

    Category.where.not(name: category.name).each do |cat|
      #Only run if the cell is not tagged
      cdscell = category.cdscells.find_by(name: "uncategorized")
      if !cdscell
        user.tag(cdscell, :with => "uncategorized", :on => :categories)
      end
    end
    
  end
  
end
