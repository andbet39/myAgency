Rails.application.routes.draw do
  resources :interactions
  devise_for :users
  get 'my_listing/index'

  resources :searches
  resources :listings
  get 'porta_portese/index'
  get 'porta_portese/run_search'
  get 'results' , to: 'listings#view'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
