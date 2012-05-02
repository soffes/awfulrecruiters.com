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

def filters
  @filters ||= settings.cache.get('filter')
  unless @filters
    f = recruiters.values.flatten
    @filters = []
    f.each_slice(40).to_a.each do |fs|
      @filters << fs.map { |domain| "*@#{domain}" }.join(' OR ')
    end
    @filters = @filters.join("\n\n")
    settings.cache.set('filter', @filters)
  end
  @filters
end

get '/' do
  erb :index, locals: { recruiters: recruiters, filters: filters }
end

get '/gmail.xml' do
  headers(
    'Content-Type' => 'application/force-download; charset=utf-8',
    'Content-Disposition' => 'attachment; filename=awful-recruiters-filter.xml'
  )
  erb :gmail, locals: { filter: filter }, layout: false
end
