Rails.application.routes.draw do

  devise_for :users
  resources :projects
	# Data requests
	post '/api/v1/projects/:name/' => 'data_api#create'

	root :to => "projects#index"
end
