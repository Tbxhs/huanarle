Spendon::Application.routes.draw do
  root :to => 'index#index'
  match 'sign_in' => 'index#index', :as => :sign_in, :via => [:get, :post]
  match 'sign_up' => 'index#sign_up', :as => :sign_up, :via => [:get, :post]
  match 'sign_out' => 'index#sign_out', :as => :sign_out
  match 'subjects' => 'home#index', :as => :subjects, :via => :get
  # match 'consumptions/new' => 'consumptions#new', :as => :new_consumption
  resources :subjects
  resources :users do
    resources :categories
    resources :blogs
  end

  scope 'settings', :controller => 'settings' do
    match 'basic', :as => :settings, :via => [:get, :post]
    match 'avatar', :as => :avatar_setting, :via => [:get, :post]
    match 'reset_password', :as => :reset_password, :via => [:get, :post]
  end

  match 'statistics' => 'statistics#index', :as => :statistics

  match 'home' => 'home#index', :as => :home

  namespace :admin do
    resources :users
  end

  match 'auth/weibo/callback' => 'auth#weibo_login'
  # match 'auth/developer/callback' => 'auth#login'
  
  match ':controller(/:action(/:id))(.:format)'
end
