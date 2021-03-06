begin
  require_relative '.env'
rescue LoadError
  abort "\n.env.rb file does not exist. Please add it.\n\n"
end

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

# Server
desc "run app via thin in 'development'"
task :dev_server do
	system("thin -R config.ru -p #{ENV['PORT']} start")
end


# Migrate
migrate = lambda do |env, version|
  ENV['RACK_ENV'] = env
  DB = Sequel.connect(ENV['DB_URL'])
  require 'logger'
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout) if DB.loggers.empty?
  Sequel::Migrator.apply(DB, 'migrate', version)
end

desc "Migrate test database to latest version"
task :test_up do
  migrate.call('test', nil)
end

desc "Migrate test database all the way down"
task :test_down do
  migrate.call('test', 0)
end

desc "Migrate test database all the way down and then back up"
task :test_bounce do
  migrate.call('test', 0)
  Sequel::Migrator.apply(DB, 'migrate')
end

desc "Migrate development database to latest version"
task :dev_up do
  migrate.call('development', nil)
end

desc "Migrate development database to all the way down"
task :dev_down do
  migrate.call('development', 0)
end

desc "Migrate development database all the way down and then back up"
task :dev_bounce do
  migrate.call('development', 0)
  Sequel::Migrator.apply(DB, 'migrate')
end

desc "Migrate production database to latest version"
task :prod_up do
  migrate.call('production', nil)
end

# Seed
desc "Seed development database"
task :dev_seed do
  system 'ruby seed/user.rb'
end


# Shell
irb = proc do |env|
  ENV['RACK_ENV'] = env
  sh "irb -r ./models"
end

desc "Open irb shell in test mode"
task :test_irb do 
  irb.call('test')
end

desc "Open irb shell in development mode"
task :dev_irb do 
  irb.call('development')
end

desc "Open irb shell in production mode"
task :prod_irb do 
  irb.call('production')
end