class Silicontracker < ActiveRecord::Base
  belongs_to :silicon, class_name: "Silicon"
  belongs_to :cdscell, class_name: "Cdscell"
  validates :cdscell_id, presence: true
  validates :silicon_id, presence: true
end
