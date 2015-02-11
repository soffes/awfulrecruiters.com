require 'rubygems'
require 'bundler'
Bundler.require :test

require 'minitest/autorun'
require './awful'

class TestCase < MiniTest::Test
  include Rack::Test::Methods

  def app
    AwfulRecruiters.new
  end
end
