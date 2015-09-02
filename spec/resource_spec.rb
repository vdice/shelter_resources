require('spec_helper')

describe Resource do
    it { should have_many :items }
    it { should have_many :shelters }
    it ('returns a lowercase name if name one word') do
      new_resource = Resource.create({name: "Bed"})
      expect(new_resource.name).to(eq("bed"))
    end
  end
