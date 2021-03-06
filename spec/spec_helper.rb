ENV['RACK_ENV'] = 'test'

require './app/server'
require 'database_cleaner'
require 'capybara/rspec'
require 'coveralls'
require 'simplecov'

Capybara.app = Sinatra::Application

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
Coveralls.wear!

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end


