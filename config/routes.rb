Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions',
    registrations: 'users/registrations'}
    
    devise_scope :user do
      match '/sessions/user', to: 'users/sessions#create', via: :post
    end

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
 

  resources :users
  resources :sessions
  resources :shopping_carts
  resources :addresses 
  resources :orders, only: [:new]
  post '/checkout/create',to: 'checkout#create'
 
  
  namespace :admin do
    root 'sessions#new'
    resources :sessions
    resources :categories
    resources :products
  end
  
  resources :categories, only: [:show]
  resources :products do
    get :search, on: :collection
  end
  


  
end
