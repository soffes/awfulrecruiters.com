class AwfulRecruiters < Sinatra::Application
  get '/' do
    erb :index
  end
end
