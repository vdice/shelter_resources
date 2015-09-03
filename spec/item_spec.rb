require('spec_helper')

describe Item do
  it{ should belong_to :resource }
  it{ should belong_to :shelter }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quantity) }
end
