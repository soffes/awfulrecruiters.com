require 'sinatra'
require 'safe_yaml'

class AwfulRecruiters < Sinatra::Application
  configure do
    set :root, File.dirname(__FILE__)
    set :views, Proc.new { File.join(root, 'views') }
    SafeYAML::OPTIONS[:default_mode] = :safe
  end

  get '/' do
    erb :index, locals: { recruiters: recruiters, filters: filters }
  end

  private

  def recruiters
    @recruiters ||= YAML.load_file(File.join(settings.root, 'recruiters.yml'))
  end

  def filters
    @filters ||= begin
      f = recruiters.values.flatten
      filters = []
      f.each_slice(40).to_a.each do |fs|
        filters << fs.map { |domain| "*@#{domain}" }.join(' OR ')
      end
      filters.join("\n\n")
    end
  end
end
