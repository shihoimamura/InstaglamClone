Rails.application.routes.draw do
  resources :contacts
  resources :sessions, only: [:new, :create, :destroy]
  resources :pictures do
    collection do
      post :confirm
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update]

  post "favorite", to: "pictures#favorite"
  get "favorite/:id", to: "users#favorite"

  root 'pictures#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
