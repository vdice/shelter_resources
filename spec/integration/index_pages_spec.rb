require('spec_helper')

describe('the index/nav bar paths', {:type => :feature}) do
  before(:each) do
    @url = '/'
    @donate = {:name => 'donate', :title => 'Donate:'}
    @support = {:name => 'support', :title => 'Find Support:'}
    @about_us = {:name => 'about_us', :title => 'About Us'}
  end

  describe('initial state') do
    it('greets user with initial state') do
      visit(@url)
      expect(page).to have_content('Xenia')
      expect(page).to have_content('Donate')
      expect(page).to have_content('Find Support')
      expect(page).to have_content('About Us')
    end
  end

  describe('the Donate path') do
    it('takes user to the donate page') do
      visit(@url)
      find("##{@donate[:name]}_link").click
      expect(page).to have_content(@donate[:title])
    end
  end

  describe('the Support path') do
    it('takes user to the support page') do
      visit(@url)
      find("##{@support[:name]}_link").click
      expect(page).to have_content(@support[:title])
    end
  end

  describe('the nav bar links') do
    it('takes user to donate page') do
      visit(@url)
      find("#nav_#{@donate[:name]}_link").click
      expect(page).to have_content(@donate[:title])
    end
    it('takes user to support page') do
      visit(@url)
      find("#nav_#{@support[:name]}_link").click
      expect(page).to have_content(@support[:title])
    end
    it('takes the user to the about us section') do
      visit(@url)
      find("#nav_#{@about_us[:name]}_link").click
      expect(page).to have_content(@about_us[:title])
    end
  end

  describe('the mobile nav menu links') do
    it('takes user to donate page') do
      visit(@url)
      find("#nav_mobile_#{@donate[:name]}_link").click
      expect(page).to have_content(@donate[:title])
    end
    it('takes user to support page') do
      visit(@url)
      find("#nav_mobile_#{@support[:name]}_link").click
      expect(page).to have_content(@support[:title])
    end
    it('takes the user to the about us section') do
      visit(@url)
      find("#nav_mobile_#{@about_us[:name]}_link").click
      expect(page).to have_content(@about_us[:title])
    end
  end

end
