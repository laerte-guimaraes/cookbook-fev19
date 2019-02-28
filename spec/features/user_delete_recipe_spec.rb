require 'rails_helper'

feature 'User delete recipe' do
  
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path
    click_on recipe.title
    click_on 'Deletar'
   
    expect(Recipe.count).to eq(0)
    expect(current_path).to eq(root_path)
  end

  scenario 'with one or more recipes' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe1 = Recipe.create(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    recipe2 = Recipe.create(title: 'Bolo sem Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine,
                  cook_time: 30, ingredients: 'Farinha, açucar',
                  cook_method: 'Corte em pedaços pequenos, misture com o restante dos ingredientes',
                  user: user)

    visit root_path
    click_on recipe1.title
    click_on 'Deletar'   
    
    expect(Recipe.count).to eq(1)
    expect(current_path).to eq(root_path)
    expect(page).to have_css('h1', text: recipe2.title)
    expect(page).not_to have_css('h1', text: recipe1.title)
  end

end