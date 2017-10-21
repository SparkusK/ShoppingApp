Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # -- Sessions -- #
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # -- Households -- #
  get '/search_household', to: 'households#search'
  get '/leave_household/:id', to: 'households#leave', as: :leave_household
  post 'leave_with_delete/:id', to: 'households#leave_with_delete', as: :leave_with_delete
  post 'leave_with_transfer/:old/:new', to: 'households#leave_with_transfer', as: :leave_with_transfer
  post 'leave_member/:id', to: 'households#leave_member', as: :leave_member
  post 'kick_member/:member_id', to: 'households#kick_member', as: :kick_member
  post 'close_household/:household_id', to: 'households#close_household', as: :close_household
  post 'open_household/:household_id', to: 'households#open_household', as: :open_household

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :households, only: [:new, :create, :edit, :update]

  # -- Invitations -- #
  post 'rescind_invitation/:household_id/:user_id', to: 'invitations#rescind_invitation', as: :rescind_invitation
  post 'rescind_application/:household_id/:user_id', to: 'invitations#rescind_application', as: :rescind_application
  post 'decline_application/:household_id/:user_id', to: 'invitations#decline_application', as: :decline_application
  post 'accept_application/:household_id/:user_id', to: 'invitations#accept_application', as: :accept_application
  post 'decline_invitation/:household_id/:user_id', to: 'invitations#decline_invitation', as: :decline_invitation
  post 'accept_invitation/:household_id/:user_id', to: 'invitations#accept_invitation', as: :accept_invitation

  post 'create_household_application/:user_id/:household_id', to: 'invitations#create_household_application', as: :create_household_application
  post 'create_household_invitation/:user_id/:household_id', to: 'invitations#create_household_invitation', as: :create_household_invitation
  get 'search_members/:search_query', to: 'invitations#search_members', as: :search_members
  get 'search_households/:search_query', to: 'invitations#search_households', as: :search_households

  # -- Shopping Lists -- #
  get 'search_item/', to: 'shopping_list#search_item', as: :search_item
  post 'delete_item/:household_id/:item_id', to: 'shopping_list#delete_item', as: :delete_item
  post 'add_items/', to: 'shopping_lists#add_item', as: :add_items
  get 'select_items/', to: 'shopping_list#select_items', as: :select_items

  post 'create_shopping_list/:household_id', to: 'shopping_list#create_shopping_list', as: :create_shopping_list
end
