require 'rubygems'
require 'bundler'
Bundler.require

task :clean do
  cache = Dalli::Client.new
  
  recruiters = YAML.load_file('recruiters.yml')
  cache.set('recruiters', recruiters)
  
  f = recruiters.values.flatten
  filters = []
  f.each_slice(40).to_a.each do |fs|
    filters << fs.map { |domain| "*@#{domain}" }.join(' OR ')
  end
  filters = filters.join("\n\n")
  settings.cache.set('filters', filters)
end
