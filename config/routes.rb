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
  post 'close_household', to: 'households#close', as: :close_household
  post 'open_household', to: 'households#open', as: :open_household

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :households

  # -- Invitations -- #
  post 'rescind_invitation/:household_id/:user_id', to: 'invitations#rescind', as: :rescind_invitation
  post 'decline_application/:household_id/:user_id', to: 'invitations#decline', as: :decline_application
  post 'accept_application/:household_id/:user_id', to: 'invitations#accept', as: :accept_application
  get 'search_members/:search_query', to: 'invitations#search_members', as: :search_members

  get 'search_households/:search_query', to: 'invitations#search_households', as: :search_households
  

end
