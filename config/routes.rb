Rails.application.routes.draw do

  devise_for :admins, skip: :all
  devise_scope :admin do
    get 'admin/sign_in' => 'admin/sessions#new', as: 'new_admin_session'
    post 'admin/sign_in' => 'admin/sessions#create', as: 'admin_session'
    delete 'admin/sign_out' => 'admin/sessions#destroy', as: 'destroy_admin_session'
    get 'admin/sign_up' => 'admin/registrations#new', as: 'new_madmin_registration'
    post 'admin' => 'admin/registrations#create', as: 'admin_registration'
  end

  namespace :admin do
      resources :homes, only: [:top]
      resources :members, only: [:index,:show, :edit, :update, :destroy]
      resources :posts, only: [:index, :show, :destroy] do
        resources :post_comments, only: [:destroy]
      end
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
    post 'follow/:id' => 'relationships#follow', as: 'follow'
    delete 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
    get "search" => "searches#search"
    get 'inquiry' => 'inquiry#index'              # 入力画面
    post 'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
    post 'inquiry/thanks' => 'inquiry#thanks'     # 送信完了画面
    resources :notifications, only: :index
    resources :members, only: [:show, :edit, :update, :destroy]do
      get :following, :follower, :following_index,on: :member
    end
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

  end

end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
