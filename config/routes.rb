Rails.application.routes.draw do
  devise_for :users , :controllers => {registrations: 'registrations' }

  root 'site#index'

  get '/about', to: 'site#about'

  get '/users', to: 'users#index'

  get '/users/:id', to: 'users#show'

  get '/users/:id/ratings', to: 'users#ratings'

  get '/users/:id/reviews', to: 'users#reviews'

  get '/products', to: 'products#index'

  get '/products/:id', to: 'products#show'

  get '/products/:product_id/reviews/new', to: 'reviews#new'

  post '/products/:product_id/reviews', to: 'reviews#create'

  get '/reviews/:id', to: 'reviews#show'

  get '/reviews/:id/edit', to: 'reviews#edit'

  post '/reviews/:id', to: 'reviews#update'

  delete '/reviews/:id', to: 'reviews#delete'

  get '/reviews/:review_id/user_ratings/new', to: 'user_ratings#new'

  post '/reviews/:review_id/user_ratings', to: 'user_ratings#create'

  get '/user_ratings/:id/edit', to: 'user_ratings#edit'

  post 'user_ratings/:id', to: 'user_ratings#update'

  delete '/user_ratings/:id', to: 'user_ratings#delete'

  get '/search', to: 'searches#main'

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
