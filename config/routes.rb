Rails.application.routes.draw do
  root to: 'shorten_urls#index'
  resources :shorten_urls
  get "/:short_url", to: "shorten_urls#show"
  get "shortened/:short_url", to: "shorten_urls#shortened"
  post "/shortened_urls/create", to: "shorten_urls#create"
  post "/shortened_urls/analytics", to: "shorten_urls#analytics"
  # get "/shortened_urls/fetch_original_url"
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
