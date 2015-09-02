require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }
require('pry')
require('geokit')

configure do
  set :geocoder, Geokit::Geocoders::GoogleGeocoder3
  set :portland_bounds, settings.geocoder.geocode('Portland').suggested_bounds
  set :bias, { :bias => settings.portland_bounds }
end

get('/locator') do
  @resources = Resource.all()
  erb(:locator)
end

post('/locator') do
  shelters = Shelter.all()

  source_name = params.fetch('source_name')
  @source = [params.fetch('source_street'),
             params.fetch('source_city'),
             params.fetch('source_state')].join(',')

  @geocoded_source = settings.geocoder.geocode(@source, settings.bias)

  with_distance = []
  shelters.each do |shelter_obj|
    geocoded_shelter = settings.geocoder.geocode(shelter_obj.location(), settings.bias)
    with_distance << [shelter_obj, (geocoded_shelter).distance_to(@geocoded_source)]
  end

  @sorted_shelters = with_distance.sort{|a, b| a[1] <=> b[1]}
  @resources = Resource.all()

  erb(:locator)
end
