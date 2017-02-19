Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root :to => 'reviews#index', as: :authenticated_root
    end
    root to: "devise/sessions#new"
    #root to:  "static_pages#activation_payment"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  get 'reviews/refresh' => 'reviews#refresh', :as => :refresh_reviews
get 'reviews/create_ad' => 'reviews#create_ad'

  #get 'reviews/index' => 'reviews#index', :as => :refresh_reviews
end
