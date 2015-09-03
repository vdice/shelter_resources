require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }
require('pry')

require('geokit')
include(HelperMethod)

configure do
  set :geocoder, Geokit::Geocoders::GoogleGeocoder3
  set :portland_bounds, settings.geocoder.geocode('Portland').suggested_bounds
  set :bias, { :bias => settings.portland_bounds }
end

get('/locator') do
  @resources = Resource.all()
  erb(:locator)
end

post('/locator/results') do
  shelters = Shelter.all()

  @source = [params.fetch('source_street'),
             params.fetch('source_city'),
             params.fetch('source_state')].join(',')

  @geocoded_source = settings.geocoder.geocode(@source, settings.bias)

  with_distance = []
  shelters.each do |shelter_obj|
    geocoded_shelter = settings.geocoder.geocode(shelter_obj.address(), settings.bias)
    distance = (geocoded_shelter).distance_to(@geocoded_source).round(2)
    shelter_obj.latitude=geocoded_shelter.lat
    shelter_obj.longitude=geocoded_shelter.lng
    with_distance << [shelter_obj, distance]
  end

  @sorted_shelters = with_distance.sort{|a, b| a[1] <=> b[1]}[0...5]
  @resources = Resource.all()

  erb(:locator_results)
end

get('/') do
  erb :index
end

get '/donate' do
  @resources = Resource.all
  erb :donate
end

get '/donates/:id' do
  @resource = Resource.find(params['id'].to_i)
  @resource_name = HelperMethod.capitalize_multiple_words(@resource.name)
 @items = @resource.items
    erb :donate_need
end
