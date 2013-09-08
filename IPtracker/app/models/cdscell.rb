class Cdscell < ActiveRecord::Base

  #Attributes  
  attr_accessor :libname
  attr_accessor :imgpath
  
  belongs_to :cdslib
  
  #Cell Tracker
  has_many :celltrackers, foreign_key: "tracked_id", dependent: :destroy
  has_many :trackers, through: :celltrackers, source: :tracker
  
  #Silicon Tracker
  has_many :silicontrackers, foreign_key: "cdscell_id", dependent: :destroy
  has_many :silicons, through: :silicontrackers, source: :silicon
  
  #Categories
  has_many :cell_categories, foreign_key: "cdscell_id", dependent: :destroy
  has_many :categories, through: :cell_categories, source: :category  
  
  #before_save :generate_image
  after_destroy :delete_image
  
  #Validations
  default_scope -> { order('cdslib_id ASC , area DESC') }
  validates :cdslib_id, presence: true
  validates :name,  presence: true, 
                    length: { maximum: 140 }
  validates :xsize, presence: true, numericality: { only_integer: true }                    
  validates :ysize, presence: true, numericality: { only_integer: true }                    
  validates :area, presence: true, numericality: { only_integer: true }

  #has_attached_file :libimg, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => 'missing.png'
  
  ## Silicons
  
  def used_in_silicon?(silicon)
    silicontrackers.find_by(silicon_id: silicon.id)
  end
  def add_silicon!(silicon)
    silicons = self.silicons.find_by(name: silicon.name)
    silicontrackers.create!(silicon_id: silicon.id) if !silicons
  end
  def rm_silicon!(silicon)
    silicontrackers.find_by(silicon_id: silicon.id).destroy!
  end
  
  
  ## Categories
  
  def in_category?(category)
    cell_categories.find_by(category_id: category.id)
  end
  def add_category!(category)
    categories = self.categories.find_by(name: category.name)
    cell_categories.create!(category_id: category.id) if !categories
  end
  def rm_category!(category)
    cell_categories.find_by(category_id: category.id).destroy!
  end
  
  def add_category_list!(user,category_list)
    
    #Create the categories if the do not exist
    categories = Category.create_from_list(user,category_list)
  
    #get the current categories assigned to the cell (for a give user)
    assigned_categories = self.categories & user.categories
    
    removed_categores = assigned_categories - categories    
    
    #Remove already assigned categories
    removed_categores.each do |category|
      self.rm_category!(category)
    end
    
    #Tag cell with each category
    categories.each do |category|
      self.add_category!(category)
    end
    
    #Remove empty categories
    Category.cleanup!(user)
    
  end
    
  ## Images
  
  def update_png_location(destination_path)
    self.layimg_file_name = destination_path
    self.save! 
  end
  
  def image_name
    File.basename(self.layimg_file_name)
  end
  
  #Delete the image when the cell is deleted
  def delete_image
    cellname = self.name
    libid = self.cdslib.id
    
    imgFilePath = Rails.root.join('public','layouts','#{libid}_#{cellname}')
    
  end
  
  #Depricated, would generate an image
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
