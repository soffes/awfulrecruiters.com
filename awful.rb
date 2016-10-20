require 'sinatra'
require 'safe_yaml'
require 'json'

class AwfulRecruiters < Sinatra::Application
  configure do
    set :root, File.dirname(__FILE__)
    set :views, Proc.new { File.join(root, 'views') }
    SafeYAML::OPTIONS[:default_mode] = :safe
  end

  get '/' do
    request.accept.each do |type|
      case type.to_s
      when 'text/html'
        halt erb :index, locals: { recruiters: recruiters, filters: filters }
      when 'text/json', 'application/json'
        json_data = {
          recruiters: recruiters,
          filters: filters.split("\n\n")
        }
        halt json_data.to_json
      end
    end
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
