ENV['RACK_ENV'] = 'test'
require 'sinatra/activerecord'
require 'rspec'
require 'pg'

require './lib/resource'
require './lib/shelter'

require 'capybara/rspec'

require './app'

RSpec.configure do |config|
  config.after(:each) do
    Resource.all.each do |task|
      task.destroy
    end
    Shelter.all.each do |task|
      task.destroy
    end
  end
end
