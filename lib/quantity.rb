class Quantity < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :resource
  validates :quantity, presence: true
end
