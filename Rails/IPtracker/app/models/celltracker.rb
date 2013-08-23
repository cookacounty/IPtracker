class Celltracker < ActiveRecord::Base
  belongs_to :tracker, class_name: "User"
  belongs_to :tracked, class_name: "Cdscell"
  validates :tracker_id, presence: true
  validates :tracked_id, presence: true
end