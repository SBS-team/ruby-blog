require 'resque/server'
RubyBlog::Application.routes.draw do
  devise_for :admins
  root :to => 'users#index'
  authenticate :admin do
    mount Resque::Server.new, :at => "/resque"
  end
  scope "/" do
    get "/post/:id" => "users#show", :as => :show_post_comments
    post "/post/:id" => "users#create", :as => :create_comment
  end

  get "/administration" => "administration/comments#index"
  get "/search" => "search#index"

  get "/categories/:name" => "tags#index", :as => :tags

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
    get '/vk' => "sitemap#vk"
  end
  delete "/administration/tags/destroy/:id" => "administration/tags#destroy!", :as => :administration_destroy_tag
  get "/administration/search_tag" => "administration/tags#search_tag", :as => :administration_search_tag
end
