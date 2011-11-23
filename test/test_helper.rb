require "minitest/autorun"
require "minitest/rails"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"

class MiniTest::Rails::Spec
  include ActiveSupport::Testing::Assertions
  include RR::Adapters::MiniTest

  class << self
    alias context describe
  end

  def build_message(*args)
    args[1].gsub(/\?/, '%s') % args[2..-1]
  end
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

  def subject
    self.class.desc.new
  end
end

MiniTest::Spec.register_spec_type MiniTest::Rails::Model do |klass|
  klass.superclass == ActiveRecord::Base
end

require "action_controller/test_case"
require "shoulda/matchers/action_controller"

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

  include Shoulda::Matchers::ActionController
  extend Shoulda::Matchers::ActionController

  def subject
    @controller
  end
end

MiniTest::Spec.register_spec_type /Controller/, MiniTest::Rails::Controller

require "action_dispatch/testing/integration"

require "capybara/rails"
require "capybara/rspec/matchers"

class MiniTest::Rails::Acceptance < MiniTest::Rails::Spec
  include MiniTest::Rails::Fixtures
  include Capybara::DSL
  include Capybara::RSpecMatchers
end
