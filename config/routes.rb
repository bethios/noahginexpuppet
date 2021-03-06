Rails.application.routes.draw do

  resources :products

  resources :projects, only: [:new, :create, :destroy, :index]

  resources :posts

  resources :users, only: [:new, :create, :edit, :update]

  resources :sessions, only: [:new, :create, :destroy]

  resources :charges, only: [:new, :create]

  get 'complete' => 'charges#complete'

  get 'admin' => 'welcome#admin'

  get 'about' => 'posts#about'

  get 'puppets' => 'posts#puppets'

  get 'art' => 'posts#art'

  get 'events' => 'posts#events'

  get 'hire' => 'posts#hire'

  match '/send_inquiry', to: 'posts#send_inquiry', via: 'post'

  root 'welcome#index'

end
