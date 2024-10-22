# # Rails.application.routes.draw do

# # namespace :admin do
# #   get "reports/index"
# #   get "reports/show"
# # end

# #   get "home/index"
# #   get "employees/dashboard"
# #   get "admins/dashboard"
# #   devise_for :users
# #   authenticated :user, ->(u) { u.admin? } do
# #     get "admin/dashboard", to: "admins#dashboard", as: :admin_dashboard
# #   end

# #   authenticated :user, ->(u) { u.employee? } do
# #     get "employee/dashboard", to: "employees#dashboard", as: :employee_dashboard
# #   end

# #   resources :employees do
# #     get 'dashboard', on: :member
# #   end



# #   root to: "home#index"



# #   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

# #   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
# #   # Can be used by load balancers and uptime monitors to verify that the app is live.
# #   get "up" => "rails/health#show", as: :rails_health_check

# #   # Render dynamic PWA files from app/views/pwa/*
# #   get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
# #   get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

# #   # Defines the root path route ("/")
# #   # root "posts#index"
# # end


Rails.application.routes.draw do
  get "home/index"
  get "employees/dashboard"
  get "admins/dashboard"
  get "employees/index"
  get "employees/show"
  get "employees/new"
  get "employees/edit"
  # get "employee/dashboard", to: "employees#dashboard"
  post "employee/show", to: "employees#show"

  # resources :employees, only: [ :index, :new, :create ]
  resources :employees, only: [ :show ]

  devise_for :users

  authenticated :user, ->(u) { u.admin? } do
    get "admin/dashboard", to: "admins#dashboard", as: :admin_dashboard
    resources :employees, path: "admin/employees", only: [ :index, :show, :edit, :update, :destroy ]
  end


  authenticated :user, ->(u) { u.employee? } do
    get "employee/dashboard", to: "employees#dashboard", as: :employee_dashboard
    resources :employees, only: [ :show ]
  end

  resources :employees do
    member do
      get "dashboard"
    end
  end

  resources :admins do
    member do
      get "dashboard"
    end
  end

  namespace :admin do
    # get 'dashboard' => 'dashboard#index'
    resources :employees, only: [ :index, :show, :edit, :update, :destroy ]
    get "reports", to: "reports#index"
    resources :reports, only: [ :index ]
    get "dashboard", to: "admins#dashboard"
  end

  namespace :admin do
    resources :employees
    resources :reports, only: [ :index, :show ] # Add reports routes here
    get "dashboard", to: "admins#dashboard"
  end

  namespace :admin do
    get "reports/index"
    get "reports/show"
  end

  namespace :admin do
    resources :employees, only: [ :index, :new, :create, :show ]
  end

  namespace :admin do
    resources :employees
  end

  resources :employees

  resources :employees do
    collection do
      get "dashboard", to: "employees#dashboard" # Adjust if necessary
    end
  end

  # resources :employees do
  #   collection do
  #     get :report
  #   end
  # end

  # # If the report is for the admin section:
  # namespace :admin do
  #   get "reports", to: "reports#index"
  # end

  # resources :employees do
  #   collection do
  #     post :find_employee # This creates a route for the find_employee action
  #   end
  # end

  # namespace :admin do
  #   resources :reports do
  #     collection do
  #       get "download_pdf", to: "reports#download_pdf"
  #     end
  #   end
  # end

  namespace :admin do
    resources :employees do
      member do
        get "view", to: "employees#show"  # Example for viewing a specific employee
      end
    end
  end

  # namespace :admin do
  #   resources :employees
  # end
  #

  resources :employees, only: [ :show ]



  # post "find_employee_report", to: "employees#find_employee", as: "find_employee_report"


  root "home#index"
end
