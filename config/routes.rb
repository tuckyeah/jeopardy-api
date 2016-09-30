Rails.application.routes.draw do
  resources :categories, except: [:new, :edit]
  resources :clues, except: [:new, :edit]
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
  resources :games, only: [:index, :create, :update, :new]
  resources :responses, only: [:index, :show]

  get '/random' => 'categories#random'
  get '/categories/:id/clues' => 'categories#clues'
  patch '/answers/:id' => 'clues#validate_answer'
end
