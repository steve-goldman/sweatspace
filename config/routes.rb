Rails.application.routes.draw do
  devise_for :users,
             controllers: { registrations: "users/registrations" },
             path_names: { sign_up: "" }

  root to: "home#home"
  get "random", to: "home#random_profile", as: :random_profile

  namespace :admin do
    resources :instructor_profiles, only: :index
    resources :class_types, except: [:show, :destroy], controller: :clazz_types
    resources :studios, except: [:show, :destroy]
    resources :studio_brands, except: [:show, :destroy]
    resources :studio_brand_studios, only: [:create, :destroy]
    resources :class_templates, except: [:show, :destroy]
    resources :class_template_class_types, only: [:create, :destroy]
    resources :invitations, only: [:index, :new, :create]
    resources :newsletter_signups, only: :index
    resource :ghosting_session, only: [:create, :destroy]
  end

  resources :classes, only: [:show, :new, :create, :edit, :update] do
    get :confirm, on: :member
    patch :confirmed, on: :member

    resource :change, controller: :class_changes, only: [] do
      post :cancel
      post :uncancel
      post :substitute
      post :unsubstitute
      post :delete
      post :delete_and_future_weeks
    end
  end

  resources :recurring_classes, only: [:index, :new, :create, :edit, :update] do
    get :confirm, on: :member
    patch :confirmed, on: :member
  end

  resources :instructor_profiles, except: :destroy do
    get :welcome, on: :collection
    get :profile_photo
  end

  namespace :instructor_profile do
    resource :profile_photo, only: :edit
    resource :social_ids, only: :edit
  end

  resource :class_templates_by_studio, only: :show, controller: :class_templates_by_studio

  resources :newsletter_signups, only: [:new, :create]
  resources :got_its, only: :create

  get :faq, to: "home#faq", as: :faq

  get "robots.txt", to: "robots#show", controller: :robots

  get "/:id", to: "instructor_profiles#show", as: :profile
end
