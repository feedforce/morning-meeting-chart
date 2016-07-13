Rails.application.routes.draw do
  root to: 'teams#index'
  resources :teams do
    resources :progresses, only: [:index, :new, :create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
