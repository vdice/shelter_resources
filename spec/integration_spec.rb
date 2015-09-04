require('spec_helper')

describe('the locator functionality', {:type => :feature}) do
  before(:each) do
    @url = '/donate'
  end

  describe('initial state') do
    it('greets user with initial state') do
      visit(@url)
      expect(page).to have_content('Donate')
    end
  end

  describe('the post path') do
    before(:each) do
      @source_street = '208 SW 5th Ave'

      @shelters = [{:shelter => Shelter.create({:name => 'Transition Projects', :address => '665 Northwest Hoyt Street, Portland, OR 97209', :phone_number => "321-456-7890"}),
                    :expected_name => 'Transition Projects',
                    :expected_address => '665 Northwest Hoyt Street, Portland, Or 97209',
                    :expected_distance => '0.39'},
                   {:shelter => Shelter.create({:name => 'Portland Rescue Mission', :address => '111 West Burnside Street, Portland, OR 97209', :phone_number => "503-906-7690"}),
                    :expected_name => 'Portland Rescue Mission',
                    :expected_address => '111 West Burnside Street, Portland, Or 97209',
                    :expected_distance => '0.22'}]

      @resource = Resource.create({:name => 'Linens'})

      Item.create({:name => 'towel', :quantity => 1, :resource_id => @resource.id(), :shelter_id => @shelters[0][:shelter].id()})
      Item.create({:name => 'towel', :quantity => 1, :resource_id => @resource.id(), :shelter_id => @shelters[1][:shelter].id()})
    end

    it('returns a sorted list of shelters based on current address and resource needed') do
      visit(@url)
      fill_in('location', :with => @source_street)
      find('#find_button').click
      expect(page).to have_selector('#shelter_listing > div > a:nth-child(1)', text: @shelters[1][:expected_name])
      expect(page).to have_selector('#shelter_listing > div > a:nth-child(1)', text: @shelters[1][:expected_distance])
      expect(page).to have_selector('#shelter_listing > div > a:nth-child(2)', text: @shelters[0][:expected_name])
      expect(page).to have_selector('#shelter_listing > div > a:nth-child(2)', text: @shelters[0][:expected_distance])
    end

    it('takes user to shelter page if a specific shelter is entered') do
      visit(@url)
      fill_in('location', :with => @source_street)
      fill_in('shelter', :with => @shelters[0][:shelter].name())
      find('#find_button').click
      expect(page).to have_content(@shelters[0][:expected_name])
      expect(page).to have_content(@shelters[0][:expected_address])
      expect(page).to have_content(@shelters[0][:shelter].phone_number())

      expect(page).to_not have_content(@shelters[1][:expected_name])
      expect(page).to_not have_content(@shelters[1][:expected_address])
      expect(page).to_not have_content(@shelters[1][:shelter].phone_number())
    end
  end

end
