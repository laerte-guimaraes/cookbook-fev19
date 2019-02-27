Rails.application.routes.draw do
  root to: 'recipes#index'
  resources :recipes do
    collection do
      get 'search'
    end
    member do
      post 'favorite'
      delete 'unfavorite'
    end
  end
  resources :recipe_types
  resources :cuisines
end
