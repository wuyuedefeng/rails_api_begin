Rails.application.routes.draw do
  # devise_for :users
  scope module: :authentication_rails do
    resource :session, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # api
  defaults format: :json do
    # v1
    namespace :v1 do
      resource :user
    end

    # admin
    namespace :admin do
      resources :users
    end
  end
end
