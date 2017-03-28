task default: [:test]

task :environment do
  require './config/environment'
end

namespace :db do
  desc "migrate the database"
  task :migrate, [:version] => :environment do |t, args|
    ActiveRecord::Migrator.migrate('./config/migrations', args[:version])
  end
end

task :test do
  system "./spec/runner"
end
