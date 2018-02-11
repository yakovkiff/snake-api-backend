Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create]
 	    post "/games", to: "games#create_or_update_game"
      # resources :games, only: [:index]
      get "/games/:username", to: "games#index"

    end
  end
end
