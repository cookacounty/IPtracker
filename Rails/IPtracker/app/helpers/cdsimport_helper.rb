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
  
  
  def cdsin_parser(fin_read,fout_path)
    libRegexp = /^\S\w+/ #first char is not white space
    cellRegexp = /^\s+\w+/ #first char is white space
    
    lineNumber = 1
    headerLines = 3
    
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
            name = isCell[0]
            cdscell = cdsin_create_cell(name,cdslib)
            fout.puts "#{prefix}CELL #{name} references #{cdscell.name+' '+ cdscell.id.to_s}"
          else        
            fout.puts "#{prefix}NOTHING"
        end
        
        lineNumber += 1
      end
      
    end

  end
  
  def cdsin_create_lib(name)
    cdslib = Cdslib.find_by(name: name)
    cdslib = Cdslib.create!(name: name) if !cdslib
    return cdslib
  end
  
  def cdsin_create_cell(name,cdslib)
    cdscell = cdslib.cdscells.find_by(name: name)
    cdscell = cdslib.cdscells.create!(name: name) if !cdscell
    return cdscell
  end
  
end
