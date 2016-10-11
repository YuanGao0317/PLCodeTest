Rails.application.routes.draw do
  resources :books
  delete '/clean' => 'books#destroy_all'
end
