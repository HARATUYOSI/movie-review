Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#top'
  resources :users
  resources :reviews
  get 'movies/link' => 'movies#link'
  resources :movies

end
