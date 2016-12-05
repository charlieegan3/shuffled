Rails.application.routes.draw do
  get 'primitive', to: 'primitive#index'
  post 'primitive', to: 'primitive#create'

  get 'image_search', to: 'image_search#index'
  post 'image_search', to: 'image_search#search'
end
