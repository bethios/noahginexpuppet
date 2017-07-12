Rails.application.routes.draw do

  resources :posts

  resources :users, only: [:new, :create]

  get 'admin' => 'posts#admin'

  get 'about' => 'posts#about'

  get 'puppets' => 'posts#puppets'

  get 'art' => 'posts#art'

  get 'face_painting' => 'posts#face_painting'

  root 'welcome#index'

end
