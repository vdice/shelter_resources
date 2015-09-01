class Shelter < ActiveRecord::Base
  has_many :quantities
  has_many :resources, through: :quantities
  before_save :lowercase_name
  before_save :lowercase_location
  validates :name, presence: true
  validates :location, presence: true

  define_singleton_method(:find_by_name) do |name|
    Shelter.all.each do |shelter|
      if shelter.name == name
        return shelter
      end
    end
    nil
end

  define_singleton_method(:find_by_location) do |location|
    Shelter.all.each do |shelter|
      if shelter.location == location
        return shelter
      end
    end
    nil
end

  private
    define_method(:lowercase_name) do
      if self.name.match(/\s/)
        self.name = name.split.each{|word|word.downcase!}.join(" ")
      else
        self.name = name.downcase!
    end
  end

    define_method(:lowercase_location) do
      if self.location.match(/\s/)
        self.location = location.split.each{|word|word.downcase!}.join(" ")
      else
        self.location = location.downcase!
      end
    end
end
