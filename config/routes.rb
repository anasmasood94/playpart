Rails.application.routes.draw do
  devise_for :users, only: []

  root 'application#health_check'
  namespace :api, defaults: { format: 'json' }do
    namespace :v1 do
      resources :auth, only: [] do
        collection do
          post :login
          post :sign_up
          post :log_out
        end
      end

      resources :users, only: [] do
        collection do
          put :update
        end
      end

      resources :reactions, only: [:create, :update, :destroy]
      resources :videos, only: [:create, :destroy] do
        collection do
          get :get_video_list
        end
      end

      resources :video_reports, only: [:create]
    end
  end
end
