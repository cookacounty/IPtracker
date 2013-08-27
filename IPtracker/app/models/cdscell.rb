class Cdscell < ActiveRecord::Base

  belongs_to :cdslib
  
  attr_accessor :libname
  
  #Cell Tracker
  has_many :celltrackers, foreign_key: "tracked_id", dependent: :destroy
  has_many :trackers, through: :celltrackers, source: :tracker
  
  #Silicon Tracker
  has_many :silicontrackers, foreign_key: "cdscell_id", dependent: :destroy
  has_many :silicons, through: :silicontrackers, source: :silicon
  
  before_save :generate_image
  
  default_scope -> { order('cdslib_id ASC , area DESC') }
  validates :cdslib_id, presence: true
  validates :name,  presence: true, 
                    length: { maximum: 140 },
                    uniqueness: { case_sensitive: true }
  validates :xsize, presence: true, numericality: { only_integer: true }                    
  validates :ysize, presence: true, numericality: { only_integer: true }                    
  validates :area, presence: true, numericality: { only_integer: true }

  
  #has_attached_file :libimg, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => 'missing.png'
  def used_in_silicon?(silicon)
    silicontrackers.find_by(silicon_id: silicon.id)
  end
  def add_silicon!(silicon)
    silicontrackers.create!(silicon_id: silicon.id)
  end
  def rm_silicon!(silicon)
    silicontrackers.find_by(silicon_id: silicon.id).destroy!
  end
  
  def generate_image 
    
    scale_factor = 4
    
    xsize = self.xsize / scale_factor
    ysize = self.ysize / scale_factor
    
    libid = self.cdslib.id
    imageMagickPath = IPtracker::Application.config.imageMagickPath
    newFilePath = Rails.root.join('public','layouts')
    newFile = "#{newFilePath}/#{libid}_#{self.name}.png"
    
    #store the image location
    self.layimg_file_name = newFile
    
    unless File.directory?(newFilePath)
      FileUtils.mkdir_p(newFilePath)
    end
    
    convertCMD = "#{imageMagickPath}convert -size #{xsize}x#{ysize} xc:grey #{newFile}"
    
    status = system(convertCMD)
    
    if(!status)
      raise "ImageMagick convert command '#{convertCMD} ' failed. Was the ImageMagick path defined in application.rb? Is ImageMagick installed?"
    end
    
    return self
  end

end
