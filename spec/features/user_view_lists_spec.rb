require 'rails_helper'

feature 'User view lists' do
  scenario 'with recipe' do
    user = User.create(email: 'email@teste.com', password: '12345678')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Torta de cenoura', difficulty: 'Médio',
          recipe_type: recipe_type, cuisine: cuisine,
          cook_time: 50,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
          user: user)
    list = List.create!(name: 'Lista Teste', user: user)
    list_recipes = ListRecipe.create!(list: list, recipe: recipe)
    

    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas Listas'
    click_on list.name

    
    expect(current_path).to eq(list_path list)
    expect(page).to have_css('h1', text: list.name)
    expect(page).to have_link(recipe.title)
  end
end