Resources::Application.routes.draw do

  resources :hangqingbaojias, only: [:index] do
    collection do 
      get "jiage_list"
      get "more_jiage_list"
      get "hangqing_list"
      get "dongtai_list"
      get "more_dongtai_list"
      get "comment"
    end
  end

  resources :jiages do 
    collection do 
      get "get_categories"
    end
  end

  resources :dongtais

  resources :hangqings

  resources :comments do
    collection do 
      get "list"
    end
  end

  resources :contacts

  resources :message_types

  resources :lanzis, only: [:index, :create, :destroy]

  resources :customer_types

  resources :customers

  resources :news

  resources :transaction_types

  resources :shangjidingzhis do 
    collection do
      get "list"
    end
  end

  resources :company_prices
  resources :jiaoyis, only: [:index, :show]
  resources :baojias, only: [:index]
  resources :hangqingbaojias, only: [:index]
  resources :zixuns, only: [:index] do 
    collection do
      get "list"
    end
  end

  get "home" => "home#index"
  get "shangbiao" => "home#shangbiao"
  get "shengming" => "home#shengming"
  get "services" => "home#services"
  get "privacy" => "home#privacy"
  get "ad" => "home#ad"
  get "lianxi" => "home#lianxi"
  get "recruit" => "home#recruit"
  get "guanggao_attachment" => "home#guanggao_attachment"
  get "search_home" => "home#search"
  get "search_by_tag_home" => "home#search_by_tag"
  get "admin" => "admin#index"

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register'}

  devise_scope :user do
    get "bianji_mima", :to => "devise/registrations#bianji_mima"
    put "update_password", :to => "devise/registrations#update_password"
  end

  resources :regions, only: [:show]

  resources :countries, only: [:show]

  get 'verify_email_exist' => "users#verify_email_exist"
  get 'verify_username_exist' => "users#verify_username_exist"

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get "entverify"
      put "verify"
      get "purview"
      get "entmember"
      put "member"
      get "home"
      get "info_and_image"
      get "edit_desc"
      put "update_desc"
      get "edit_image"
      get "edit_license"
    end
  end

  resources :transactions do
    member do
      get "images"
    end

    collection do
      get "tags"
      get "refresh"
    end

    member do
      get "change_transaction_type"
    end
  end

  delete "delete_transactions" => "transactions#destroy"

  resources :links

  resources :attachments do
    collection do
      post "upload"
    end
  end

  resources :categories, only: :show
  resources :company_price_categories, only: :show
  resources :articles
  resources :messages do
    collection do
      put "restore"
    end
  end

  constraints(Subdomain) do
    match '/' => 'member#home', as: "member_home"
    match '/member/show' => 'member#show'
    match '/member/contact' => 'member#contact'
    match '/member/transactions' => 'member#transactions'
    match '/member/transaction/:id' => 'member#transaction', as: "member_transaction"
    match '/member/news' => 'member#news'
    match '/member/message' => 'member#message'
    match '/member/news/:id' => 'member#new', as: "member_new"
  end

  root to: "home#index"

  match '*path' => proc { |env| Rails.env.development? ? (raise ActionController::RoutingError, %{No route matches "#{env["PATH_INFO"]}"}) : ApplicationController.action(:error).call(env) }  # 因为application.rb捕获不到rails路由错误，所以rails路由报错后指向application_controller.rb中的error action.


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
