require('spec_helper')

describe('the locator functionality', {:type => :feature}) do
  before(:each) do
    @url = '/locator'
  end

  describe('initial state') do
    it('greets user with initial state') do
      visit(@url)
      expect(page).to have_content('Current Location')
      expect(page).to have_content('Resource')
    end
  end

  
end
