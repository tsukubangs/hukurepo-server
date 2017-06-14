Rails.application.routes.draw do
  devise_for :users
  devise_for :users, only: []
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resource :users, only: [:create]
    resources :users, only: [:index, :show]
    resources :problems do
      collection do
        get 'me'
      end
    end
  end
end
