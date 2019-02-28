require 'rails_helper'

feature 'User sees its recipes' do
  scenario 'successfully' do
    recipe_type = RecipeType.create(name: 'Prato Principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    user = User.create(email: 'email@teste.com', password: '12345678')
    another_user = User.create(email: 'email2@teste.com', password: 'abcdefgh')
    recipe = Recipe.create(title: 'Torta de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
                           user: user)
    another_recipe = Recipe.create(title: 'Feijoada',
                                   recipe_type: recipe_type,
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes',
                                   user: another_user)

    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Minhas Receitas'

    expect(page).to have_css('h1', text: 'Minhas Receitas')
    expect(page).to have_content('Total de receitas cadastradas: 1')
    expect(page).to have_link(recipe.title)
    expect(page).not_to have_link(another_recipe.title)
  end

end