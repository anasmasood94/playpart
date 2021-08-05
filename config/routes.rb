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
    end
  end
end
