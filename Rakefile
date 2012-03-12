require 'rubygems'
require 'bundler'
Bundler.require

task :clean do
  cache = Dalli::Client.new
  
  recruiters = YAML.load_file('recruiters.yml')
  cache.set('recruiters', recruiters)
  
  filter = recruiters.values.flatten.map { |domain| "*@#{domain}" }.join(' OR ')
  cache.set('filter', filter)
end
