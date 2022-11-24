Rails.application.routes.draw do
  
  namespace :admin do
    resources :content_types
  end
  resources :admin_users
  namespace :admin do
    root 'admin#index'
    get '/login', to: 'admin#login_page'
    post '/login', to: 'admin#login'
    get '/logout', to: 'admin#logout'
    resources :content_fragments
    resources :content_pieces
    resources :fragment_templates
    resources :content_types
    resources :blog_categories
    resources :blog_posts do 
      post :publish_to_medium
      get :publish_to_mediums
    end
    resources :blog_post_categories
    resources :documents
    resources :volunteers
  end

  # Blog
  resource :blog
  get '/blog/:slug', to: 'blogs#view_article'
  get 'podcast', to: 'blogs#podcast'
  # Drug Education
  get '/drugs', to: 'drugs#home'
  post '/drugs/training', to: 'drugs#training_register'
  get '/drugs/training', to: 'drugs#training'
  # Programming
  scope :programming do
    root 'programming#home'
    get :machine_learning, to: 'programming#machine_learning'
    get :assembly, to: 'programming#assembly'
  end
    get '/data-science', to: 'programming#data_science'
  # Teaching
  get '/teaching', to: 'teaching#home'

  # Default root
  get '/', to: 'home#index'
end
