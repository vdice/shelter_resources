require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }
require('pry')

require('geokit')
include(HelperMethod)

configure do
  set :geocoder, Geokit::Geocoders::GoogleGeocoder3
end

get('/locator') do
  @resources = Resource.all()
  erb(:locator)
end

post('/locator/results') do
  shelters = Shelter.all()
  @resources = Resource.all()

  source = nil
  # fetch user lat/lng auto-populated by map.js on window load
  user_latitude = params.fetch('user_latitude')
  user_longitude = params.fetch('user_longitude')

  if (params.fetch('source_street').empty?)
    source = [user_latitude,
              user_longitude].join(', ')

  else
    source = [params.fetch('source_street'),
              params.fetch('source_city'),
              params.fetch('source_state')].join(', ')
  end

  @geocoded_source = settings.geocoder.geocode(source)
  if @geocoded_source.full_address.empty?
    @geocoded_source = settings.geocoder.geocode('Portland, OR')
  end

  # get resource selection and filter shelters based on
  # which shelters have items in need
  resource_id = params.fetch('resource_select').to_i()
  found_shelters = []
  shelters.each() do |shelter|
    include_shelter = false
    shelter.items.each() do |item|
      if (item.resource_id().eql?(resource_id))
        include_shelter = true if item.quantity().>(0)
      end
    end
    found_shelters.push(shelter) if include_shelter
  end

  # calculate distance from source to each shelter
  with_distance = []
  found_shelters.each do |shelter|
    geocoded_shelter = settings.geocoder.geocode(shelter.address())
    distance = (geocoded_shelter).distance_to(@geocoded_source).round(2)
    shelter.latitude=geocoded_shelter.lat
    shelter.longitude=geocoded_shelter.lng
    with_distance << [shelter, distance]
  end

  # sort according to distance (index 1 on with_distance array)
  @sorted_shelters = with_distance.sort{|a, b| a[1] <=> b[1]}[0...5]

  erb(:locator_results)
end

get('/') do
  erb :index
end

get '/donate' do
  @resources = Resource.all.sort{ |x,y| x.name <=> y.name }
  @shelter_arr = Shelter.all.map{|shelter_obj| shelter_obj.name }
  @route_heading = 'Donate:'

  @action = 'donate'
  erb :find_by
end


get '/resources/:id' do
  @resource = Resource.find(params['id'].to_i)
  erb :resource_inventory
end


get '/support' do
  @resources = Resource.all.sort{ |x,y| x.name <=> y.name }
  @shelter_arr = Shelter.all.map{|shelter_obj| shelter_obj.name }

  @route_heading = 'Find Support By:'
  @action = 'support'
  @find_shelter_string = 'Find Shelters by Resource:'
  erb :find_by
end

get '/shelters/:id' do
  @shelter = Shelter.find(params.fetch('id').to_i)
  erb :shelter
end

post '/support' do
  shelters = Shelter.all()

  location = params.fetch('location')

  if (location.empty?)
    # TODO: auto locate user
  else
    @geocoded_source = settings.geocoder.geocode(location)

    # calculate distance from source to each shelter
    with_distance = []
    shelters.each do |shelter|
      geocoded_shelter = settings.geocoder.geocode(shelter.address())
      distance = (geocoded_shelter).distance_to(@geocoded_source).round(2)
      shelter.latitude=geocoded_shelter.lat
      shelter.longitude=geocoded_shelter.lng
      with_distance << [shelter, distance]
    end

    # sort according to distance (index 1 on with_distance array)
    @sorted_shelters = with_distance.sort{|a, b| a[1] <=> b[1]}[0...5]

  end
  erb :locator_results
end

post '/support/shelters' do
  @shelter = Shelter.find_by_name(params.fetch('shelter'))
  redirect("/shelters/#{@shelter.id()}")
end
