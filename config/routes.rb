Ewutazas::Application.routes.draw do

  devise_for :users

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin' # Feel free to change '/admin' to any namespace you need.

  match 'trip' => 'trip#index'
  match 'order' => 'order#index'
  match 'contact' => 'contact#index'
  match 'insurance' => 'insurance#index'
  
  # match 'exclusive' => 'exclusive#hungaroring'
  match 'hungaroring' => 'exclusive#hungaroring'
  match 'fcbarcelona' => redirect("/")
  match 'gyorietovip' => 'exclusive#gyorietovip'


  match 'ajax/get_region' => 'ajax#get_region', :method => 'POST'
  match 'ajax/get_city' => 'ajax#get_city', :method => 'POST'
  match 'ajax/search_estimate' => 'ajax#search_estimate', :method => 'POST'

  # match 'uticelok/:country_name' => 'list#uticelok'

  match 'utjaink/:travel_type' => "list#index"
  match 'utjaink' => 'list#index'

  # match 'naszutak' => 'list#index'
  # match 'hajoutak' => 'list#hajoutak'
  # match 'sieles' => 'list#index'
  # match 'egzotikusutak' => 'list#index'
  # match 'korutazasok' => 'list#index'
  # match 'varoslatogatasok' => 'list#index'
  # match 'sportutak' => 'list#index'
  # match 'kulfoldiutazasok' => 'list#kulfoldiutazasok'
  # match 'belfoldiutazasok' => 'list#belfoldiutazasok'
  # match 'akciosutak' => 'list#akciosutak'
  # match 'lastminute' => 'list#lastminute'

  match 'kereses' => 'list#kereses'

  match 'kapcsolat' => 'contact#index'
  match 'biztositasok' => 'insurance#index'

  match 'foglalas/koszonjuk' => 'order#thankyou'
  match 'foglalas/:id' => 'order#index'
  match 'egyedi' => 'order#personalized'
  match 'egyedi/:id' => 'order#personalized'

  match 'list' => 'list#index', :method => 'POST'

  match 'uticelok/:country_name' => 'list#uticelok'

  match ':id/:from_date' => 'trip#show'
  match ':id' => 'trip#show', :as => :travel_offer

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
