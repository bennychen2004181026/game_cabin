Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions',
    registrations: 'users/registrations'}
    
    devise_scope :user do
      match '/sessions/user', to: 'users/sessions#create', via: :post
    end

  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
 
   #PAGE ROUTING
   get '/', to: 'home#index'
   get '/home', to: 'home#index'
   get '/index', to: 'home#index'

  #Categories Routing
  get '/categories/:id', to: 'categories#show', as: 'category'

  # Admin dashboard
  # get '/admin', to: 'admin/sessions#new', as: 'admin_root' 
  # get '/admin/sessions/new', to: 'admin/sessions#new', as: 'new_admin_session' 
  
  # admin/categories
  # get '/admin/categories', to: 'admin/categories#index', as: 'admin_categories'
  # post '/admin/categories', to: 'admin/categories#create'
  # get '/admin/categories/new', to: 'admin/categories#new', as: 'new_admin_category'
  # get '/admin/categories/:id/edit', to: 'admin/categories#edit', as: 'edit_admin_category'
  # put '/admin/categories/:id', to: 'admin/categories#update'
  # delete '/admin/categories/:id', to: 'admin/categories#destroy'
  
  # admin/categories
  # get '/admin/products', to: 'admin/products#index', as: 'admin_products'
  # post '/admin/products', to: 'admin/products#create'
  # get '/admin/products/new', to: 'admin/products#new', as: 'new_admin_product'
  # get '/admin/products/:id/edit', to: 'admin/products#edit', as: 'edit_admin_product'
  # put '/admin/products/:id', to: 'admin/products#update'
  # delete '/admin/products/:id', to: 'admin/products#destroy'
  namespace :admin do
    root 'sessions#new'
    resources :sessions, only: [:new]
    resources :categories, only: [:index,:new,:create,:edit,:update,:destroy]
    resources :products, only: [:index,:new,:create,:edit,:update,:destroy]
  end

  resources :users
  resources :sessions
  
  # address
  # get '/addresses', to: 'addresses#index', as: 'addresses'
  # get '/addresses/new', to: 'addresses#create', as: 'new_address'
  # POST '/addresses', to: 'addresses#create'
  # get '/addresses/:id/edit', to: 'addresses#edit', as: 'edit_address'
  # put '/addresses/:id', to: 'addresses#update'
  # delete '/addresses/:id', to: 'addresses#destroy'

  resources :addresses, only: [:index,:new,:create,:edit,:update,:destroy]
  resources :orders, only: [:new]
  post '/checkout/create',to: 'checkout#create'
 
  
  # categories
  # get '/categories/:id', to: 'categories#show', as: 'category'

  # products
  # get '/products/search', to: 'products#search', as: 'search_products'
  # get '/products', to: 'products#index', as: 'products'
  # POST '/products', to: 'products#create'
  # get '/products/new', to: 'products#new', as: 'new_product'
  # get '/products/:id/edit', to: 'products#edit', as: 'edit_product'
  # get '/products/:id', to: 'products#show', as: 'product'
  # PUT '/products/:id', to: 'products#update'
  # DELETE '/products/:id', to: 'products#destroy'
  
  resources :categories, only: [:show]
  resources :products do
    get :search, on: :collection
  end
  
  # shopping_carts
  # get '/shopping_carts', to: 'shopping_carts#index', as: 'shopping_carts'
  # post '/shopping_carts', to: 'shopping_carts#create'
  # put '/shopping_carts/:id', to: 'shopping_carts#update', as: 'shopping_carts'
  # delete '/shopping_carts/:id', to: 'shopping_carts#destroy'
  resources :shopping_carts, only: [:index,:create,:update,:destroy]
  
end
