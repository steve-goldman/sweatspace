Rails.application.routes.draw do
  devise_for :users
  root "home#show"
  resources :instructor_profiles
  get "/:id", to: "instructor_profiles#show", as: :profile

  namespace :admin do
    resources :clazz_types, except: :destroy
    resources :studios, except: :destroy
  end
end
