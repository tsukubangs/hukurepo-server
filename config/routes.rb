Rails.application.routes.draw do

  root 'visualized/problem_maps#index'

  namespace :visualized do
    get 'problem_maps', to: 'problem_maps#index'
    get 'graphs', to: 'graphs#show'
    get 'graphs/chart_data'
    get 'graphs/countries_data'
    get 'graphs/generation_data'
    resources :problems, only: [:index, :show]
  end

  devise_for :users, only: []
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    get 'run_smartphone_app', to: 'static#run_smartphone_app'
    resource :login, only: [:create], controller: :sessions
    post 'check_access_token', to: 'sessions#check_access_token'

    resources :users, only: [:create, :index, :show] do
      collection do
        get 'me'
        get 'me/problems', to: 'problems#me'
        get 'me/problems/count', to: 'problems#me_count'
        put 'me/device_token', to: 'device_tokens#update'
        patch 'me/device_token', to: 'device_tokens#update'
      end
      get 'problems', to: 'problems#users'
    end

    resources :problems do
      collection do
        get 'me'
        get 'me/count', to: 'problems#me_count'
        get 'responded'
      end

      resources :responses, only: [:index, :create] do
        get 'seen', to: 'responses#get_seen', on: :collection
        put 'seen', to: 'responses#put_seen', on: :collection
      end
    end

    resources :responses, only: [:show, :destroy]
  end
end
