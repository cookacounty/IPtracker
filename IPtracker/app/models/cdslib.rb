class Cdslib < ActiveRecord::Base
  has_many :cdscells, dependent: :destroy
  has_many :silicons, through: :cdscells
  
  default_scope -> { order('name DESC') }
  validates :name,  presence: true, 
                    length: { maximum: 140 },
                    uniqueness: { case_sensitive: true }
  

end
