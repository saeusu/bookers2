Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:new, :create, :index, :edit, :show, :destroy, :update]
  resources :users, only: [:show, :index, :edit, :update]
  get "home/about" => "homes#about", as: "about"
  get "/styles.css", to: redirect("/assets/application.css")
end
