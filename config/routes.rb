Rails.application.routes.draw do
  root 'map#index'

  resources :vehicles, only: %i[index create destroy] do
    resources :locations, only: :create
  end

  get 'map/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
