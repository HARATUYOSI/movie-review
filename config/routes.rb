Rails.application.routes.draw do
  devise_for :admins
  devise_for :users, :controllers => {
  :registrations => 'users/registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#top'
  resources :users, only: [:edit, :update, :show]
  get 'users/:id/favorites' => 'users#favorites'
  get 'users/:id/reviews' => 'users#reviews'
  get '/favorites/:id/best_movie' => 'favorites#best_movie'
  get 'favorites/:id/best_movie/delete' => 'favorites#best_movie_delete'
  get 'movies/link' => 'movies#link'
  resources :movies do
    resources :casts, only: [:new, :create, :destroy]
    resources :directors, only: [:new, :create, :destroy]
    resources :cast_movies, only: [:destroy]
    resources :director_movies, only: [:destroy]
    resources :favorites, only: [:create, :destroy]
    resources :reviews, only: [:new, :create,:edit,:update, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:new, :create, :destroy]
    end
  end
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  resources :contacts
  resources :genres, only: [:show]
  resources :release_years, only: [:show]
  resources :countries, only: [:show]
  resources :casts, only: [:show]
  resources :directors, only: [:show]
end
