Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users' => 'users#index'
  get 'reviews' => 'reviews#index'
end
