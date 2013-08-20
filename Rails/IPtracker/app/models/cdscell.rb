class Cdscell < ActiveRecord::Base
  belongs_to :cdslib
  
  before_save :generate_image
  
  default_scope -> { order('cdslib_id ASC , area DESC') }
  validates :cdslib_id, presence: true
  validates :name,  presence: true, 
                    length: { maximum: 140 }

  #Need to validate only one cdscell per cdslib
  #uniqueness: { case_sensitive: false }
  
  has_attached_file :libimg, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => 'missing.png'

  def generate_image 
    
    scale_factor = 4
    
    xsize = self.xsize / scale_factor
    ysize = self.ysize / scale_factor
    
    libid = self.cdslib.id
    imageMagickPath = "#{Rails.root}/../ImageMagick/"
    newFilePath = Rails.root.join('public','layouts')
    newFile = "#{newFilePath}/#{libid}_#{self.name}.png"
    
    #store the image location
    self.layimg_file_name = newFile
    
    unless File.directory?(newFilePath)
      FileUtils.mkdir_p(newFilePath)
    end
    
    convertCMD = "convert -size #{xsize}x#{ysize} xc:grey #{newFile}"
    
    system(imageMagickPath+convertCMD)
    
    return self
  end

end
