Rails.application.routes.draw do
  # root 'home#index'
  # devise_for :users
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_token]
  Sidekiq::Web.set :sessions, Rails.application.config.session_options

  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions', passwords: 'users/passwords'}
  concern :resourceful do
    collection do
      get :autocomplete
    end
  end

  concern :commentable do
    resources :comments
  end

  concern :attachable do
    resources :attachments do
      member do
        get :download
      end
    end
  end
  resources :shop_imports, concerns: %i(resourceful)

  concern :auditable do
    resources :audits
  end

  resources :shops, concerns: %i(resourceful) do
    collection do
      patch :merge
      get :export
    end

    member do
      patch :split
    end

    resources :agreements
    resources :leases
  end
  resources :organisations, concerns: :resourceful do
    resources :contacts
  end
  resources :users, concerns: :resourceful do
    resources :visitations
    resources :leases
    resources :agreements
    member do
      get :activities_counts
    end
  end
  resources :agreements, concerns: %i(resourceful commentable attachable) do
    collection do
      get :open
      get :closed
    end
    resources :leases
    resources :visitations
  end
  resources :shop_types, concerns: :resourceful
  resources :brands, concerns: :resourceful
  resources :sub_categories, concerns: :resourceful
  resources :categories, concerns: :resourceful do
    resources :sub_categories
  end
  resources :contacts, concerns: :resourceful
  resources :attachments, concerns: :resourceful
  resources :leases, concerns: %i(resourceful commentable attachable auditable) do
    collection do
      get :open
      get :submitted
      get :awaiting_approval
      get :approved
      get :cancelled
      get :declined
    end

    resources :visitations
    resources :commissions

    member do
      patch :submit
      patch :approve
      patch :close
      patch :cancel
      patch :decline
      patch :reopen
    end
  end

  resources :permissions, concerns: :resourceful

  resources :resource_types, concerns: :resourceful

  resources :roles, concerns: %i(resourceful) do
    resources :role_users
    resources :permissions
  end

  resources :workflows, concerns: %i(resourceful) do
    resources :workflow_ranks do
      resources :workflow_memberships
    end
  end

  resources :workflow_ranks, concenrs: %i(resourceful) do
    resources :workflow_rank_memberships
  end

  resources :workflow_rank_memberships, concenrs: %i(resourceful) 

  resources :workflow_logs, concenrs: %i(resourceful)


  root :to => 'contacts#index'
end
