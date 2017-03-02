Rails.application.routes.draw do

  get 'service_test/index'

  resources :zones
  root "searches#index"

  get 'my_interaction/index'
  get 'my_interaction/new'
  post 'my_interaction/create'

  resources :interactions

  devise_for :users


  get 'my_listing/index'

  resources :searches
  resources :listings
  get 'porta_portese/index'
  get 'porta_portese/run_search'

  get 'results' , to: 'listings#view'

namespace 'api' do
  get 'listing_for_search', to: 'listings#getListingForSearch'
  get 'togglefav', to: 'listings#togglefav'
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
