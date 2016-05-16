require 'coveralls'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'active_support/test_case'
require 'action_controller/test_case'
Coveralls.wear!

ENV['RAILS_ENV'] ||= 'test'

require 'api_controller'

#Rails.backtrace_cleaner.remove_silencers!

# Load support files
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
#ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...
end

#if ActionDispatch::IntegrationTest.method_defined?(:fixture_path=)
#  ActionDispatch::IntegrationTest.fixture_path = File.expand_path("../fixtures", __FILE__)
#end

#module Blorgh
#  class ActionController::TestCase
#    setup do
#      @routes = Engine.routes
#    end
#  end
#
#end
