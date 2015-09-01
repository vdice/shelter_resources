class Shelter < ActiveRecord::Base
  has_many :quantities
  has_many :resources through: :quantities
end
