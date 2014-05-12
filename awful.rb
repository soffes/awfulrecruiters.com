class AwfulRecruiters < Sinatra::Application
  get '/' do
    erb :index, locals: { recruiters: recruiters, filters: filters }
  end

  private

  def recruiters
    @recruiters ||= YAML.load_file('recruiters.yml')
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
