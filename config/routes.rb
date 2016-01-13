Rails.application.routes.draw do
  devise_for :users
  root "home#show"

  namespace :admin do
    resources :clazz_types, except: [:show, :destroy]
    resources :studios, except: [:show, :destroy]
  end

  resources :instructor_profiles, except: :destroy
  get "/:id", to: "instructor_profiles#show", as: :profile
end
