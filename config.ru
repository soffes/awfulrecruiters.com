require 'rubygems'
require 'bundler'
Bundler.require

require 'sinatra'
require './main'
run Sinatra::Application
