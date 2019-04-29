Rails.application.routes.draw do
  root 'pages#home'
  get  'pages/home'
  get  'users',     to: 'users#index'
  get  'users/:id', to: 'users#show', as: 'user'  
  get  'signup',    to: 'users#new'
  post 'signup',    to: 'users#create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
