get '/' do
  @recruiters = YAML.load_file('recruiters.yml')
  filter = '*@' + [@recruiters['thirdparty'] + @recruiters['companies'] + @recruiters['other']].flatten.join('OR *@')
  erb :index, locals: { recruiters: @recruiters, filter: filter }
end
