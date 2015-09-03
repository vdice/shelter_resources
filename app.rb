require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }
require('pry')

require('geokit')
include(HelperMethod)

configure do
  Geokit::Geocoders::request_timeout = 5
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

  erb(:locator_results)
end

get('/') do
  erb :index
end

get '/donate' do
  @resources = Resource.all
  @shelter_arr = Shelter.all.map{|shelter_obj| shelter_obj.name }
  erb :donate
end


get '/resources/:id' do
  @resource = Resource.find(params['id'].to_i)
  erb :resource_inventory
end
