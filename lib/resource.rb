class Resource < ActiveRecord::Base
  has_many :items
  has_many :shelters, through: :items
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

  define_singleton_method(:find_by_address) do |address|
    Resource.all.each do |resource|
      if resource.address == address
        return resource
      end
    end
    nil
  end

private
  define_method(:lowercase_name) do
    self.name.downcase!
  end
end
