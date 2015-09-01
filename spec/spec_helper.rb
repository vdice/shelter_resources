ENV['RACK_ENV'] = 'test'

require('bundler/setup')
Bundler.require(:default, :test)
set(:root, Dir.pwd())

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

require('rspec')
require('capybara/rspec')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

require './app'

RSpec.configure do |config|
  config.after(:each) do
    Resource.all.each do |task|
      task.destroy
    end
    # Shelter.all.each do |task|
    #   task.destroy
    # end
    Quantity.all.each do |task|
      task.destroy
    end
  end
end
