IPtracker::Application.routes.draw do
  

  #get "cdsimport/import"
  #post "cdsimport/upload"
  resources :cdsimport do
    member do
      get 'import'
      post 'upload'
    end
  end
  
  match '/import',  to: 'cdsimport#import',            via: 'get'
  post "cdsimport/upload"
  
  resources :cdscells do
    member do
      get :tracking
    end
  end
  match '/cdscell_convert_json', to: 'cdscells#convert_json', via: 'get'
  
  #It's common to have resources that are logically children of other resources.
  #Nested routes allow you to capture this relationship in your routing. 
  #resources :cdslibs do
  #  resources :cdscells
  #end
  
  resources :cdslibs

  resources :users do
    member do
      get :following, :followers, :tracked
    end
  end
  
  #get 'tracked', to: 'users#tracked'
  
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :celltrackers, only: [:create, :destroy]

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/browse',   to: 'static_pages#browse',   via: 'get'
  match '/layout',   to: 'static_pages#layout',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/references', to: 'static_pages#references', via: 'get'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # CONTROLLER=users rake routes
  
  
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
