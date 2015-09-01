require('spec_helper')

describe Quantity do
    it{ should belong_to :resource }
    it{ should belong_to :shelter }
  end
