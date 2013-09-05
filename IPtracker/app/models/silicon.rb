class Silicon < ActiveRecord::Base
  has_many :cdscells
  
  #Silicon Tracker
  has_many :silicontrackers, foreign_key: "silicon_id", dependent: :destroy
  has_many :cdscells, through: :silicontrackers, source: :cdscell
  
  has_many :cdslibs, -> { uniq }, :through => :cdscells
  
  VALID_SILICON_REGEX = IPtracker::Application.config.silicon_regex
  validates :name,  presence: true,
                    format: { with: VALID_SILICON_REGEX, message: "is not a valid Silicon Name"},
                    uniqueness: { case_sensitive: false }
  before_save { name.upcase! }
                    

end
