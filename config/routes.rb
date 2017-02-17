Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'home#index', as: :authenticated_root
    end
    root to: "devise/sessions#new"
    #root to:  "static_pages#activation_payment"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
