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
    resources :class_template_class_types, only: [:create, :destroy]
  end

  resources :classes, only: [:index, :new, :create, :edit, :update] do
    get :confirm, on: :member
    patch :confirmed, on: :member

    resource :change, controller: :class_changes, only: :show do
      post :cancel
      post :uncancel
      post :delete
      post :last_in_repeating_class
    end
  end

  resources :repeating_classes, only: [:index, :new, :create, :edit, :update] do
    get :confirm, on: :member
    patch :confirmed, on: :member
  end

  resources :instructor_profiles, except: :destroy
  get "/:id", to: "instructor_profiles#show", as: :profile
end
