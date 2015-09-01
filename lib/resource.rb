class Resource < ActiveRecord::Base
  has_many :quantities
  has_many :shelters, through: :quantities
end
