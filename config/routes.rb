Rails.application.routes.draw do
  resources :shared_infos
  root to: 'teams#index'
  resources :teams do
    resources :goals do
      resources :progresses
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
