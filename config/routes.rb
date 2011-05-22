TableReservation::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions

  match 'users/:id/delete' => 'users#destroy', :as => :delete_user
  match 'all_users_csv' => 'users#all_users_csv', :as => :all_users_csv
  match 'all_users' => 'users#all_users', :as => :all_users
  match 'users/:id/admin_update' => 'users#admin_update', :as => :admin_update_user
  match 'user' => 'users#show', :as => :user

  resources :users

  resources :restaurants

  match 'restaurants/:id' => 'restaurants#show', :via => [:post]
  match 'restaurants/:id/delete' => 'restaurants#destroy', :as => :delete_restaurant
  match 'restaurants/show_admin/:id' => 'restaurants#show_admin', :as => :restaurant_show_admin
  match 'remove_from_exclusives/:id' => 'restaurants#remove_from_exclusives', :as => :remove_from_exclusives
  match 'add_to_exclusives/:id' => 'restaurants#add_to_exclusives', :as => :add_to_exclusives

  match 'admin' => 'admin#show', :as => :admin

  match 'passwords/forgot' => 'passwords#forgot', :as => :forgot_password
  match 'passwords/generate' => 'passwords#generate', :as => :generate_password
  match 'passwords/update' => 'passwords#update', :as => :update_password

  match 'contact' => 'contact#show', :as => :contact
  match 'contact/send' => 'contact#send_mail', :as => :contact_send

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "sessions#show"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
