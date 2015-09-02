require('spec_helper')

describe Shelter do
    it { should have_many :quantities }
    it { should have_many :resources }
    it ('returns a lowercased multiple word name') do
      new_shelter = Shelter.create({name: "TaLKing", address: "space"})
      expect(new_shelter.name).to(eq("talking"))
    end

    it ('returns a lowercased multiple word address') do
      new_shelter = Shelter.create({name: "doug", address: "421 TaLking HeAds LaNE"})
      expect(new_shelter.address).to(eq("421 talking heads lane"))
  end
end
