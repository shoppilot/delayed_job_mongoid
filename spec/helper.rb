require 'simplecov'
require 'coveralls'

SimpleCov.formatters = [SimpleCov::Formatter::HTMLFormatter, Coveralls::SimpleCov::Formatter]

SimpleCov.start do
  add_filter '/spec/'
  minimum_coverage(76.39)
end

require 'rspec'
require 'delayed_job_mongoid'
require 'delayed/backend/shared_spec'
require 'mongoid/compatibility'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
  config.before :all do
    Mongoid.logger.level = Logger::INFO
    mongoid_version = Mongoid::Compatibility::Version
    if mongoid_version.mongoid5? || mongoid_version.mongoid6? || mongoid_version.mongoid7?
      Mongo::Logger.logger.level = Logger::INFO
    end
  end
end

Mongoid.configure do |config|
  config.connect_to('dl_spec')
end
