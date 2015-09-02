require('spec_helper')

describe Shelter do
    it { should have_many :items }
    it { should have_many :resources }
    it ('returns a lowercased multiple word name') do
      new_shelter = Shelter.create({name: "TaLKing", address: "space", phone_number: "321-456-7890"})
      expect(new_shelter.name).to(eq("talking"))
    end

    it ('returns a lowercased multiple word address') do
      new_shelter = Shelter.create({name: "doug", address: "421 TaLking HeAds LaNE", phone_number: "321-456-7890"})
      expect(new_shelter.address).to(eq("421 talking heads lane"))
    end

    it ('returns a phone_number') do
      new_shelter = Shelter.create({name: "doug", address: "421 TaLking HeAds LaNE", phone_number: "321-456-7890"})
      expect(new_shelter.phone_number).to(eq("321-456-7890"))
    end
end
