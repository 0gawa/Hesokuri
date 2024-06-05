Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: "about"
    get 'homes/privacy', to: 'homes#privacy', as: 'privacy'
    get 'homes/terms-of-use', to: 'homes#use', as: 'terms_of_use'
    resources :users, only: [:show, :update]
    get '/mypage' => 'users#mypage', as: "mypage"
    get '/mypage/setmoney' => 'users#set_money', as: "set_money"
    post '/mypage' => 'users#create_money', as: "create_money"
    patch '/mypage/setmoney' => 'users#set_save_money', as: "set_save_money"
    get '/mypage/edit'=>'users#edit', as: "edit_user"
    get 'mypage/unsubscribed' => 'users#unsubscribed', as: 'confirm_unsubscribed'
    patch '/mypage' => 'users#withdrawal', as: 'withdrawal'
    resources :spends, only: [:new, :index, :create]
    resources :spend_genres, except: [:show]
    resources :incomes, only: [:new, :index, :create]
  end
 
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
  end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
