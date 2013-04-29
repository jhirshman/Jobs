StartXJobs::Application.routes.draw do
  resources :locations


  resources :categories


  resources :applications
  match 'applications/new/:id' => 'applications#new', :as => "new_application"
  match 'applications/job/:id' => 'applications#showForJob', :as => "show_apps"

  resources :jobs


  resources :companies
  match 'company/' => 'company#index'
  match 'company/edit' => 'company#editProfile', :as => "edit_profile", :via => "get"


  match 'admin/' => 'admin#adminPanel', :as => 'admin_panel', :via => "get"
  match 'admin/newCompany' => 'admin#newCompany', :via => "post"
  match 'admin/assignUserToCompany' => 'admin#assignUserToCompany', :via => "post"

  devise_for :users

  match 'user/' => 'pages#userLanding'
  namespace :user do
    root :to => "pages#userLanding"
  end

  #root :to => 'pages#main'
  root :to => 'jobs#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
