require('spec_helper')

describe Shelter do
    it { should have_many :quantities }
    it { should have_many :resources }
    it ('returns a lowercased multiple word name') do
      new_shelter = Shelter.create({name: "TaLKing", location: "space", phone_number: "321-456-7890"})
      expect(new_shelter.name).to(eq("talking"))
    end

    it ('returns a lowercased multiple word location') do
      new_shelter = Shelter.create({name: "doug", location: "421 TaLking HeAds LaNE", phone_number: "321-456-7890"})
      expect(new_shelter.location).to(eq("421 talking heads lane"))
    end

    it ('returns a phone_number') do
      new_shelter = Shelter.create({name: "doug", location: "421 TaLking HeAds LaNE", phone_number: "321-456-7890"})
      expect(new_shelter.phone_number).to(eq("321-456-7890"))
    end
end
