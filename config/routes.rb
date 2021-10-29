Rails.application.routes.draw do
  root to: 'pages#home'
  resources :movies, only: %i[index]
end
