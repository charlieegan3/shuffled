Rails.application.routes.draw do
  get 'primitive', to: 'primitive#index'
  post 'primitive', to: 'primitive#create'
end
