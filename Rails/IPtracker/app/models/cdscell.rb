class Cdscell < ActiveRecord::Base
  belongs_to :cdslib
  default_scope -> { order('name DESC') }
  validates :cdslib_id, presence: true
  validates :name,  presence: true, 
                    length: { maximum: 140 }

  #Need to validate only one cdscell per cdslib
  #uniqueness: { case_sensitive: false }
  
  has_attached_file :libimg, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => 'missing.png'

end
