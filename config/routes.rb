Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations", sessions: "users/sessions" },
             path_names: { sign_up: "" }

  root to: "home#dashboard"
  get "/login", to: "home#landing", as: :landing

  namespace :admin do
    resources :class_types, except: [:show, :destroy], controller: :clazz_types
    resources :studios, except: [:show, :destroy]
    resources :class_templates, except: [:show, :destroy]
    resources :class_template_studios, only: [:create, :destroy]
  end

  resources :classes, only: :index do
    resources :setup, controller: :class_setup, only: [:show, :update]
    post "new_class", to: "class_setup#new", as: :new_setup, on: :collection
  end

  resources :instructor_profiles, except: :destroy
  get "/:id", to: "instructor_profiles#show", as: :profile
end
