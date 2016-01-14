Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" },
             path_names: { sign_up: "" }

  root to: "home#dashboard"
  get "/login", to: "home#landing", as: :landing

  namespace :admin do
    resources :class_types, except: [:show, :destroy], controller: :clazz_types
    resources :studios, except: [:show, :destroy]
  end

  resources :classes, except: [:show, :destroy]
  resources :instructor_profiles, except: :destroy
  get "/:id", to: "instructor_profiles#show", as: :profile
end
