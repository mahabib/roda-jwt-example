ENV['RACK_ENV'] = 'test'

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

namespace :app do
	desc "test by test name: rake app:t test_invalid_general_login"
	task :t do |t, args|
		ENV['RACK_ENV'] = 'test'
    Rake::Task['test_bounce'].invoke

		ARGV.each { |a| task a.to_sym do ; end }

		testname = ARGV[1]

		dirs = File.join('tests', 'ts_*.rb')
		test_files = Dir.glob(dirs)

		matches = test_files.collect do |filename|
			filename if !File.open(filename).grep(/#{testname}/).empty?
		end.compact

		if matches.count > 1
			puts
			matches.each { |f| puts f }
			puts
			abort "'#{testname}' exists in multiple test files"
		end

		filename = matches.first
		command = "bundle exec 'ruby #{filename} -n #{testname}'"

		puts exec command
	end

	desc "test by number & name: rake app:tt 21 test_invalid_general_login"
	task :tt do |t, args|
		ENV['RACK_ENV'] = 'test'
    Rake::Task['test_bounce'].invoke

		tests_dir = File.expand_path(File.join(__dir__, 'tests'))

		ARGV.each { |a| task a.to_sym do ; end }

		test_file_number = ARGV[1]

		files = File.join('tests', "ts_#{test_file_number}*.rb")
		test_files = Dir.glob(files)

		if test_files.empty?
			abort "Error - Invalid file number"
			abort
		end

		test_file = test_files.first
		testname = ARGV[2]
		if testname.nil?
			command = "bundle exec 'ruby #{test_file}'"
		else
			command = "bundle exec 'ruby #{test_file} -n #{testname}'"
		end

		puts exec command
	end

	desc "to test all apis"
	task :test do
		require 'rake/testtask'

		ENV['RACK_ENV'] = 'test'
    Rake::Task['test_bounce'].invoke

		tests_files_path = File.expand_path(File.join(File.dirname(__FILE__), 'tests/**/ts_*.rb'))

		Rake::TestTask.new(:alltest) do |t|
			t.test_files = FileList[tests_files_path]
			# t.verbose = true
			t.verbose = false
			t.warning = false
		end

		Rake::Task['alltest'].invoke
	end
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