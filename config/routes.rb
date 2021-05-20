Rails.application.routes.draw do

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admin/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: 'destroy_admin_session'
  end

  namespace :admin do
    root :to => 'homes#top'
      resources :homes, only: [:top]
    #   collection do
    #     get 'search'
    #   end
    # end
    # resources :items, only: [:new, :index, :create, :show, :edit, :update]
    # post 'items/search'
    # resources :genres, only: [:index, :create, :edit, :update]
    # resources :customers, only: [:index, :show, :edit, :update]
    # post 'customers/search'
    # resources :order_details, only: [:update]
    # resources :orders, only: [:show, :update]
  end

  devise_for :members, skip: :all
  devise_scope :member do
    get 'members/sign_in' => 'public/sessions#new', as: 'new_member_session'
    post 'members/sign_in' => 'public/sessions#create', as: 'member_session'
    delete 'members/sign_out' => 'public/sessions#destroy', as: 'destroy_member_session'
    get 'members/sign_up' => 'public/registrations#new', as: 'new_member_registration'
    post 'members' => 'public/registrations#create', as: 'member_registration'
  end

  scope module: :public do
    root :to => 'homes#top'
    post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
    resources :members, only: [:show, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

  end

end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
