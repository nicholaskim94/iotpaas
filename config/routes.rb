Rails.application.routes.draw do

post '/api/v1/projects/:name/' => 'projects_api#create'

end
