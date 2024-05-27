Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: "about"
    resources :users, only: [:show, :edit, :update]
    get '/mypage' => 'users#mypage', as: "mypage"
    get '/mypage/setmoney' => 'users#set_money', as: "set_money"
    post '/mypage' => 'users#create_money', as: "create_money"
    resources :spends, only: [:new, :index, :create]
    resources :spend_genres, except: [:show]
  end
 
  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
  end
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
