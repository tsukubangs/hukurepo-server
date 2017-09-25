Rails.application.routes.draw do
  devise_for :users, only: []
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    get 'run_smartphone_app', to: 'static#run_smartphone_app'
    resource :login, only: [:create], controller: :sessions
    post 'check_access_token', to: 'sessions#check_access_token'
    resource :users, only: [:create]
    resources :users, only: [:index, :show] do
      get 'me', on: :collection
      get 'me/problems', to: 'problems#me', on: :collection
      get 'me/problems/count', to: 'problems#me_count', on: :collection
      put 'me/device_token', to: 'device_tokens#update', on: :collection
      get 'problems', to: 'problems#users'
    end
    resources :problems do
      get 'me', on: :collection
      get 'me/count', to: 'problems#me_count', on: :collection
      resources :responses, only: [:index, :create] do
        get 'seen', to: 'responses#get_seen', on: :collection
        put 'seen', to: 'responses#put_seen', on: :collection
      end
    end
    resources :responses, only: [:show, :destroy]
  end
end
