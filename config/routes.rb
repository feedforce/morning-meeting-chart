Rails.application.routes.draw do
  resources :teams do
    resources :progresses do
      resources :topics
    end
  end
end
