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

  describe('the post path') do
    before(:each) do
      @source_street = '208 SW 5th Ave'


      @shelters = [{:shelter => Shelter.create({:name => 'Transition Projects', :location => '665 Northwest Hoyt Street, Portland, OR 97209', :phone_number => "321-456-7890"}),
                    :expected_distance => '0.39'},
                   {:shelter => Shelter.create({:name => 'Portland Rescue Mission', :location => '111 West Burnside Street, Portland, OR 97209', :phone_number => "321-456-7890"}),

                    :expected_distance => '0.22'}]

      @resource = Resource.create({:name => 'bed'})
    end

    it('returns a sorted list of shelters based on current address and resource needed') do
      visit(@url)
      fill_in('source_street', :with => @source_street)
      find('#resource_select').find("#option_#{@resource.id()}").select_option
      click_button('Find')
      expect(page).to have_selector('#shelter_listing > ul > li:nth-child(1)', text: @shelters[1].fetch(:shelter).name())
      expect(page).to have_selector('#shelter_listing > ul > li:nth-child(1)', text: @shelters[1].fetch(:expected_distance))
      expect(page).to have_selector('#shelter_listing > ul > li:nth-child(2)', text: @shelters[0].fetch(:shelter).name())
      expect(page).to have_selector('#shelter_listing > ul > li:nth-child(2)', text: @shelters[0].fetch(:expected_distance))
    end
  end

end
