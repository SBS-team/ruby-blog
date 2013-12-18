require 'resque/server'

RubyBlog::Application.routes.draw do

  devise_for :admins

  root :to => 'posts#index'

  authenticate :admin do
    mount Resque::Server.new, :at => '/resque'
  end

  resources :posts, only: [:index, :show]
  get '/categories/:name' => 'posts#posts_by_tag', :as => :posts_by_tag
  post '/posts/:name/comment' => 'posts#comment_create', :as => :comment_create
  get '/search' => 'posts#posts_search', :as => :posts_search

  get '/administration' => 'administration/comments#index'

  namespace :administration do
    resources :admins
    resources :posts do
      collection do
        get :preview
      end
      resources :comments, :only => [:new, :create]
    end
    resources :comments, :except => [:new, :create]
    resources :tags
    resources :sitemap, :only => [:index, :create]
  end
  delete '/administration/tags/destroy/:id' => 'administration/tags#destroy!', :as => :administration_destroy_tag
  get '/administration/search_tag' => 'administration/tags#search_tag', :as => :administration_search_tag
end