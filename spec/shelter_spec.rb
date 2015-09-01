require('spec_helper')

describe Shelter do
    it { should have_many :quantities }
    it { should have_many :resources }
    it ('returns a lowercased multiple word name') do
      new_shelter = Shelter.create({name: "TaLKing", location: "space"})
      expect(new_shelter.name).to(eq("talking"))
    end

    it ('returns a lowercased multiple word location') do
      new_shelter = Shelter.create({name: "doug", location: "421 TaLking HeAds LaNE"})
      expect(new_shelter.location).to(eq("421 talking heads lane"))
  end
end
