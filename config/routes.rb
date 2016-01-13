Rails.application.routes.draw do
  devise_for :users
  root "home#show"
  resources :instructor_profiles
  get "/:id", to: "instructor_profiles#show", as: :profile
end
