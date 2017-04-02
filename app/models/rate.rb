class Rate < ActiveRecord::Base

  scope :before, ->(date) { where("date < ?", date) }
end
