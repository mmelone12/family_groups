FamilyGroups::Application.routes.draw do

  resources :users do
    member do
      get :following, :followers
      get :group_following, :group_followers
      get :activity_following, :activity_followers
      get :place_following, :place_followers
      get :matches
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :groups, only: [:new, :create, :index]
  resources :group_relationships, only: [:create, :destroy]
  resources :activities, only: [:new, :show, :create, :destroy, :index]
  resources :activity_relationships, only: [:create, :destroy]
  resources :places, only: [:new, :create, :show, :destroy, :index]
  resources :place_relationships, only: [:create, :destroy]
  resources :interests, only: [:index, :show]
  resources :sent, only: [:new, :show, :create, :destroy]
  resources :mailbox, only: [:index]
  resources :messages, only: [:show]
  resources :friendships, only: [:create, :destroy]
  resources :invites, only: [:create]
  resources :plans, only: [:index]
  resources :subscriptions, only: [:new, :create]
  resources :posts do 
    member do
      resources :comments
    end
  end

  root 'static_pages#home'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/team', to: 'static_pages#team', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/howitworks', to: 'static_pages#howitworks', via: 'get'
  match '/premium', to: 'static_pages#premium', via: 'get'
  match '/signupalready', to: 'static_pages#signupalready', via: 'get'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
