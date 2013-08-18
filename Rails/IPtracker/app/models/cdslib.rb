class Cdslib < ActiveRecord::Base
  has_many :cdscells, dependent: :destroy
  default_scope -> { order('name DESC') }
  validates :name,  presence: true, 
                    length: { maximum: 140 },
                    uniqueness: { case_sensitive: false }
  
  
end
