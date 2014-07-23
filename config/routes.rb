Rails.application.routes.draw do
  root 'main#index'
  get "/index" =>"main#index"

  get '/about-us' =>"main#about"

  get '/contact-us' =>"main#contact"

  get '/match-data' =>"statistics#match_data"
  get '/statistics/:match_id' => "statistics#match_statistic"

  devise_for :scouts, :controller => {:session => 'session'}
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  #root 'controller#method'
  #match "url" => "controller#method", via: [:get, :post]
  #get "url" => "controller#method"
  #post "url" => "controller#method"

  devise_scope :scout do
    get 'login' => "session#login", :as => "login"
    post 'create' => 'session#create', :as => 'create'
    get 'logout' => 'session#destroy', :as => 'logout'
  end

  scope 'api' do
    get 'teams' => 'data#teams'
    get 'players/:team_id' => 'data#players_of_team'
    get 'cities' => 'data#cities'
    get 'halls/:city_id' => 'data#halls_of_city'
    get 'referees' => 'data#referees'
    post 'save_match' => 'data#save_match'

  end

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
