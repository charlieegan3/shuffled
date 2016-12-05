Rails.application.routes.draw do
  root to: 'cards#index'

  get '/cards/print', to: 'cards#print', as: :cards_print
  resources :cards

  get 'primitive', to: 'primitive#index'
  get 'primitive/from_url', to: 'primitive#create_from_url'
  post 'primitive', to: 'primitive#create'

  get 'image_search', to: 'image_search#index'
  get 'image_search/results', to: 'image_search#search'
end
