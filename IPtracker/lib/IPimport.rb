require 'fileutils'

class IPimport
  
  
  attr_accessor :tarfile
  attr_accessor :tmppath
  attr_accessor :destination

  #Initialize with application defaults
  def initialize
    @tarfile = Settings.iptracker.tar_file
    @tmppath = Settings.iptracker.tmp_path
    @destination = Settings.iptracker.png_path
    
    puts tarfile
    puts tmppath
    puts destination
    
    #Create all needed directories
    FileUtils.mkdir_p(@tmppath) unless File.directory?(@tmppath)
    FileUtils.mkdir_p(@destination) unless File.directory?(@destination)
    
  end  
  
  #Initialize with custom defaults
  #def initialize(tarfile,tmppath,destination)
  #  @tarfile = tarfile.to_s
  #  @tmppath = tmppath.to_s
  #  @destination = destination.to_s
  #  puts tarfile
  #  puts tmppath
  #  puts destination
    
  #  FileUtils.mkdir_p(@destination) unless File.directory?(@destination)
    
  #end
  
  def untar
    
    puts "Untarring file"
    tar_cmd = "cd #{@tmppath} && tar xzvf #{@tarfile} "
    puts "Running #{tar_cmd}"
    system(tar_cmd)
    
  end
  
  def move(libid,libname,cellname)
    
    puts "moving image"
    
    destination_path = "#{@destination}/#{libid}_#{cellname}.png"
    
    mvcmd = "mv #{@tmppath}/#{libname}_#{cellname}.png #{destination_path}"
    puts mvcmd
    
    system(mvcmd)
    
    return destination_path
    
  end
  
  def cleanup
    FileUtils.rm_rf(@tmppath)
  end
end