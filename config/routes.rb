Rails.application.routes.draw do
  devise_for :users
  devise_for :users, only: []
  resources :problems
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :users, only: [:create, :show]
    resources :users, only: [:index]
  end
end
