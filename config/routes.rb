Rails.application.routes.draw do
  devise_for :users, only: []
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :users, only: [:create]
    resources :users, only: [:index, :show] do
      get 'me', on: :collection
      get 'me/problems', to: 'problems#me', on: :collection
      get 'problems', to: 'problems#users'
    end
    resources :problems do
      get 'me', on: :collection
      resources :responses, only: [:index, :create]
    end
    resources :responses, only: [:show]
  end
end
