set :cache, Dalli::Client.new

def recruiters
  @recruiters ||= settings.cache.get('recruiters')
  unless @recruiters
    loaded = YAML.load_file('recruiters.yml')
    settings.cache.set('recruiters', loaded)
    @recruiters = loaded
  end
  @recruiters
end

def filter
  @filter ||= settings.cache.get('filter')
  unless @filter
    f = recruiters.values.flatten.map { |domain| "*@#{domain}" }.join(' OR ')
    settings.cache.set('filter', f)
    @filter = f
  end
  @filter
end

get '/' do
  erb :index, locals: { recruiters: recruiters, filter: filter }
end

get '/gmail.xml' do
  headers(
    'Content-Type' => 'application/force-download; charset=utf-8',
    'Content-Disposition' => 'attachment; filename=awful-recruiters-filter.xml'
  )
  erb :gmail, locals: { filter: filter }, layout: false
end
