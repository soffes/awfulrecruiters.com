def recruiters
  @recruiters ||= YAML.load_file('recruiters.yml')
end

def build_filter(domains)
  domains.map{|domain| "*@#{domain}"}.join(' OR ')
end

get '/' do
  filter = build_filter(recruiters.values.flatten)
  erb :index, locals: { recruiters: recruiters, filter: filter }
end

get '/gmail' do
  headers({
    'Content-Type' => 'application/force-download; charset=utf-8',
    'Content-Disposition' => 'attachment; filename=recruiter_filter.xml'
  })
  erb :gmail,
      locals: { filter: build_filter(recruiters.values.flatten) },
      layout: false
end
