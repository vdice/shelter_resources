class Resource < ActiveRecord::Base
  has_many :quantities
  has_many :shelters, through: :quantities
  validates :name, presence: true
  before_save :lowercase_name

define_singleton_method(:find_by_name) do |name|
  Resource.all.each do |resource|
    if resource.name == name
      return resource
    end
  end
  nil
end

define_singleton_method(:find_by_location) do |location|
  Resource.all.each do |resource|
    if resource.location == location
      return resource
    end
  end
  nil
end

private
  define_method(:lowercase_name) do
    if self.name.match(/\s/)
      self.name = name.split.each{|word| word.downcase!}.join(" ")
    else
      self.name = name.downcase!
  end
end

end
