Rails.application.routes.draw do
  resources :vehicles, only: :create

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
