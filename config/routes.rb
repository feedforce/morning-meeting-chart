Rails.application.routes.draw do
  resources :teams do
    resources :progresses, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
