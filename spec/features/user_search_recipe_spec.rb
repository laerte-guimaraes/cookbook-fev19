require 'rails_helper'

feature 'User search recipe' do
  
  scenario 'and finds one result' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes')
    other_recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

    visit root_path
    fill_in 'Pesquisa de Receita', with: 'Bolo de Chocolate'
    click_on 'Buscar'
    
    expect(page).to have_css('h1', text: 'Busca de Receitas')
    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 1')
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).not_to have_css('h3', text: other_recipe.title)
  end

end