class Item < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :resource
  validates :quantity, presence: true
  validates :name, presence: true
end
