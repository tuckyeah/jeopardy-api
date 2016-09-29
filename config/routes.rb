Rails.application.routes.draw do
  resources :categories, except: [:new, :edit]
  resources :clues, except: [:new, :edit]
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
  resources :games, only: [:index, :create]

  get '/random' => 'categories#random'
end
