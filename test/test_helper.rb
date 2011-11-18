require "minitest/autorun"
require "minitest/rails"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"

class MiniTest::Rails::Spec
  include ActiveSupport::Testing::Assertions
end

require "active_record/fixtures"

module MiniTest::Rails::Fixtures
  def self.included(klass)
    klass.class_eval do
      include ActiveSupport::Testing::SetupAndTeardown
      include ActiveRecord::TestFixtures
      self.fixture_path = File.join(Rails.root, "test", "fixtures")
    end
  end
end

class MiniTest::Rails::Model
  include MiniTest::Rails::Fixtures
end

require "action_controller/test_case"

class MiniTest::Rails::Controller
  include MiniTest::Rails::Fixtures
  include ActionController::TestCase::Behavior

  before do
    klass = self.class.name.match(/((.*)Controller)/)[1].constantize

    @controller = klass.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.env['PATH_INFO'] = nil
    @routes = Rails.application.routes
  end
end

require "action_dispatch/testing/integration"

require "capybara/rails"
require "capybara/rspec/matchers"

class MiniTest::Rails::Integration < MiniTest::Rails::Spec
  include MiniTest::Rails::Fixtures
  include Capybara::DSL
  include Capybara::RSpecMatchers
end

# valid_attribute-1.2.0 + minitest-matchers_1.1.0
class MiniTest::Rails::Model
  include ValidAttribute::Method
end
