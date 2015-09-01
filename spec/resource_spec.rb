require('spec_helper')

describe Resource do
    it { should have_many :quantities }
    it { should have_many :shelters }
    it ('returns a lowercase name') do
      new_resource = Resource.create({name: "Bed"})
      expect(new_resource.name).to(eq("bed"))
    end
  end
