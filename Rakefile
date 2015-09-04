require('sinatra/activerecord')
require('sinatra/activerecord/rake')
require('./lib/shelter.rb')
require('./lib/item.rb')
require('./lib/resource.rb')

namespace(:db) do
  task(:load_config)

  task(:init) do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['db:test:prepare'].execute
  end
end
