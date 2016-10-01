Rails.application.routes.draw do
  resources :categories, except: [:new, :edit]
  resources :clues, except: [:new, :edit]
  resources :examples, except: [:new, :edit]
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
  resources :games, except: [:edit]
  resources :responses, only: [:index, :show]

  get '/random' => 'categories#random'
  get '/categories/:id/clues' => 'categories#clues'
  patch '/answer/:clue_id/:game_id' => 'clues#validate_answer'
end
