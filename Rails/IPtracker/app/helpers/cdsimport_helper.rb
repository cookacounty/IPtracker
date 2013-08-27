module CdsimportHelper
  
  def parse_cds_file(fin)
    begin
      fin_read = fin.read
      fullpath = Rails.root.join('public', 'uploads', fin.original_filename)
      cdsin_parser(fin_read,fullpath)

      flash[:success] = "SUCESSFULLY READ FILE #{fin.original_filename}"
    rescue Encoding::UndefinedConversionError 
      File.delete(fullpath)
      flash[:error] = "FILE DOES NOT APPEAR TO BE TEXT \r\n #{fin.original_filename}"
    #rescue NoMethodError 
      #flash[:error] = "PLEASE SPECIFY A FILE"
    end
  end
  
  
  def cdsin_parser(silicon_name,fin_read,fout_path)
    
    #Create or update the silicon
    silicon = cdsin_create_silicon(silicon_name)
    
    libRegexp = /^\S\w+/ #first char is not white space
    cellRegexp = /^\s+\w+.+/ #first char is white space
    
    lineNumber = 1
    headerLines = 1
    
    cdslib = nil
    
    File.open(fout_path, 'w') do |fout|
      
      fin_read.each_line do |line|
        isLib  = line.match(libRegexp)
        isCell = line.match(cellRegexp)
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
            fout.puts "#{prefix}CELL #{name} references #{cdscell.name+' '+ cdscell.id.to_s}"
          else        
            fout.puts "#{prefix}NOTHING"
        end
        
        lineNumber += 1
      end
      
    end

  end
  
  def cdsin_create_lib(name)
    cdslib = Cdslib.find_by_name(name)
    
    if cdslib
      cdslib.touch(:updated_at)
    else
      cdslib = Cdslib.create!(name: name)
    end
      
    return cdslib
  end
  
  def cdsin_create_cell(silicon,cdslib,name,xsize,ysize,area)
    cdscell = cdslib.cdscells.find_by_name(name)
    
    if cdscell
      cdscell.update!(xsize: xsize, ysize: ysize, area: area)
      cdscell.add_silicon!(silicon)
    else
      cdscell = cdslib.cdscells.create!(name: name, xsize: xsize, ysize: ysize, area: area)
    end
    return cdscell
  end
  
  def cdsin_create_silicon(name)
    silicon = Silicon.find_by_name(name)
    
    if silicon
      silicon.touch(:updated_at)
    else
      silicon = Silicon.create!(name: name)
    end
      
    return silicon
  end
  
end
