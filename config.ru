require 'rubygems'
require 'bundler'
Bundler.require

use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

require './awful'
run AwfulRecruiters
