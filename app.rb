require('bundler/setup')
Bundler.require(:default)

Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }
require('pry')
require('geokit')

get('/') do
  # @shelters = ['providence park', 'forest park']
  @sorted_shelters = []
  erb(:locator)
end

post('/') do
  shelters = [{:name => 'providence park, portland'}, {:name => 'forest park, portland'}] #Shelter.all() #should be able to access .ll

  geocoded_source = Geokit::Geocoders::GoogleGeocoder3.geocode params.fetch('source')

  with_distance = []
  shelters.each do |shelter_obj|
    ll = Geokit::Geocoders::GoogleGeocoder3.geocode shelter_obj.fetch(:name)
    with_distance << [shelter_obj, (ll).distance_to(geocoded_source)]
  end

  @sorted_shelters = with_distance.sort{|a, b| a[1] <=> b[1]}

  erb(:locator)
end
