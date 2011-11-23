#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

DummyMinitest::Application.load_tasks

MINITEST_TASKS << "acceptance"

namespace :test do
  sub = "acceptance"
  Rake::TestTask.new(sub => 'test:prepare') do |t|
    t.libs << 'test'
    t.pattern = "test/#{sub}/**/*_test.rb"
  end
end
