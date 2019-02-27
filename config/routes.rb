Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipes do
    collection do
      get 'search'
    end
    member do
      post 'favorite'
    end
  end
  resources :recipe_types
  resources :cuisines
end
