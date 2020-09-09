Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to:'shortended_urls#index'
get "/:short_url", to: "shortended_urls#show"
get "shortended/:short_url",  to: "shortended_urls#shortended", as: :shortended
post "/shortended_urls/create"
get "/shortended_urls/fetch_original_url"
resources :shortended_urls

end
