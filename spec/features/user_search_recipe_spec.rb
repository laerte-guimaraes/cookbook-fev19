require 'rails_helper'

feature 'User search recipe' do

  scenario 'and finds one result' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe = Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    other_recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path
    fill_in 'Pesquisa de Receita', with: 'Bolo de Chocolate'
    click_on 'Buscar'
    
    expect(page).to have_css('h1', text: 'Busca de Receitas')
    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 1')
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).not_to have_css('h3', text: other_recipe.title)
  end

  scenario 'and cannot find anything' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe = Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    other_recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path
    fill_in 'Pesquisa de Receita', with: 'Pizza Doce'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Busca de Receitas')
    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 0')
    expect(page).not_to have_content(recipe.title)
    expect(page).not_to have_content(other_recipe.title)
    expect(page).to have_css('strong', text: 'Nenhuma receita encontrada !')
  end

  scenario 'and finds more than one result' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe = Recipe.create(title: 'Bolo de Chocolate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, chocolate',
                  cook_method: 'Cozinhe o chocolate, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    other_recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)
    third_recipe = Recipe.create(title: 'Torta de Abacate', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Abacate, Farinha',
                  cook_method: 'Cozinhe, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path
    fill_in 'Pesquisa de Receita', with: 'Bolo'
    click_on 'Buscar'

    expect(page).to have_css('h1', text: 'Busca de Receitas')
    expect(page).to have_css('h2', text: 'Total de Receitas encontradas: 2')
    expect(page).to have_css('h3', text: recipe.title)
    expect(page).to have_css('h3', text: other_recipe.title)
    expect(page).not_to have_content(third_recipe.title)
  end

end