require 'rails_helper'

feature 'User favorite a recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           favorite: false,
                           user: user)

    visit root_path
    click_on recipe.title
    expect(page).not_to have_link('Remover dos favoritos')
    click_on 'Favoritar'
    
    expect(current_path).to eq(recipe_path(recipe))
    expect(page).to have_css('img[src*="star.png"]')
    expect(page).not_to have_link('Favoritar')
    recipe.reload
    expect(recipe.favorite).to be_truthy
  end

end

feature 'User unfavorite a recipe' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(name: 'Brasileira')
    user =  User.create!(email: 'test_email@mail.com', password: '12345678')
    recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           favorite: true,
                           user: user)

    visit root_path
    click_on recipe.title
    expect(page).not_to have_link('Favoritar')
    click_on 'Remover dos favoritos'

    expect(current_path).to eq(recipe_path(recipe))
    expect(page).not_to have_css('img[src*="star.png"]')
    expect(page).not_to have_link('Remover dos favoritos')
    recipe.reload
    expect(recipe.favorite).to be_falsy
  end

end