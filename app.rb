require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }
require('geokit')
include(HelperMethod)

configure do
  set :geocoder, Geokit::Geocoders::GoogleGeocoder3
end

get('/') do
  erb :index
end

get '/donate' do
  get_find_by_page('donate')
end


get '/support' do
  get_find_by_page('support')
end

post '/support' do
  resolve_find_query()
  @route_heading = 'Donate:'
  @action = 'donate'

  erb :find_by
end

post '/donate' do
  resolve_find_query()
end

get '/resources/:id' do
  @resource = Resource.find(params['id'].to_i)
  @shelters = Shelter.all()
  erb :resource_inventory
end

get '/shelters/:id' do
  @shelter = Shelter.find(params.fetch('id').to_i)
  erb :shelter
end

# Helper Methods
define_method(:capitalize) do |str|
  HelperMethod.capitalize_multiple_words(str)
end

define_method(:resolve_find_query) do
  if (params.fetch('shelter').empty?)
    @geocoded_source = get_geocoded_source()
    @shelters = get_shelters_and_distances_from(@geocoded_source)
    erb :results
  else
    @shelter = Shelter.find_by_name(params.fetch('shelter'))
    redirect("/shelters/#{@shelter.id()}")
  end
end

define_method(:get_find_by_page) do |type|
  @resources = Resource.all.sort{ |x,y| x.name <=> y.name }
  @shelter_arr = Shelter.all.map{|shelter_obj| shelter_obj.name }

  support = type.eql?('support')
  @route_heading = support ? 'Find Support:' : 'Donate:'
  @action = support ? 'support' : 'donate'
  @find_shelter_string = support ? 'Find Shelters by Resource:' : 'Find Shelters by What They Need:'

  erb :find_by
end

define_method(:get_geocoded_source) do
  # fetch user lat/lng auto-populated by map.js on window load
  user_latitude = params.fetch('user_latitude')
  user_longitude = params.fetch('user_longitude')
  auto_populated_source = [user_latitude, user_longitude].join(', ')

  source = params.fetch('location').empty? ? auto_populated_source :
                                             params.fetch('location')

  geocoded_source = settings.geocoder.geocode(source)
  if geocoded_source.full_address.empty?
    geocoded_source = settings.geocoder.geocode('Portland, OR')
  end
  geocoded_source
end

define_method(:get_shelters_and_distances_from) do |geocoded_source|
  shelters = Shelter.all()

  shelters_and_distances = []
  shelters.each do |shelter|
    geocoded_shelter = settings.geocoder.geocode(shelter.address())
    distance = (geocoded_shelter).distance_to(geocoded_source).round(2)
    shelter.latitude=geocoded_shelter.lat
    shelter.longitude=geocoded_shelter.lng
    shelters_and_distances << [shelter, distance]
  end
  shelters_and_distances.sort{|a, b| a[1] <=> b[1]}[0...5]
end
