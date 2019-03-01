Rails.application.routes.draw do
  devise_for :users
  root to: 'recipes#index'
  resources :recipes do
    collection do
      get 'search'
    end
    member do
      post 'favorite'
      delete 'unfavorite'
      post 'add_list'
    end
  end

  get 'my-recipes', to: 'recipes#my_recipes'

  resources :recipe_types
  resources :cuisines
  resources :lists
end
