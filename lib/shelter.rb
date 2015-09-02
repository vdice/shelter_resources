class Shelter < ActiveRecord::Base
  has_many :quantities
  has_many :resources, through: :quantities
  before_save :lowercase_name
  before_save :lowercase_address
  validates :name, presence: true
  validates :address, presence: true

  define_singleton_method(:find_by_name) do |name|
    Shelter.all.each do |shelter|
      if shelter.name == name
        return shelter
      end
    end
    nil
end

  define_singleton_method(:find_by_address) do |address|
    Shelter.all.each do |shelter|
      if shelter.address == address
        return shelter
      end
    end
    nil
end

  private
    define_method(:lowercase_name) do
      self.name.downcase!
    end

    define_method(:lowercase_address) do
      self.address.downcase!
    end
end
