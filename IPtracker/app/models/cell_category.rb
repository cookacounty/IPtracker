class CellCategory < ActiveRecord::Base
  belongs_to :cdscell, class_name: "Cdscell"
  belongs_to :category, class_name: "Category"
  
  validates :cdscell_id, presence: true
  validates :category_id, presence: true
  
end
