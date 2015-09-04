require('sinatra/activerecord')
require('sinatra/activerecord/rake')
Dir[File.dirname('__FILE__') + '/lib/*.rb'].each{ |file| require file }

namespace :db do
  task :load_config

  task :init do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['db:test:prepare'].execute
  end
end
