ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../test/dummy/config/environment.rb', __FILE__)

require 'rails/test_help'

require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/rails/capybara'

require 'cssm-rails'

require_relative '../lib/cssm-rails'
