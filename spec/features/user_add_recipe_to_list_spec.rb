require 'rails_helper'

feature 'User add recipe to list'do
  scenario 'successfully' do
    user = User.create(email: 'email@teste.com', password: '12345678')
    recipe_type = RecipeType.create(name: 'Prato Principal')
    cuisine = Cuisine.create(name: 'Brasileira')
    recipe = Recipe.create(title: 'Torta de cenoura', difficulty: 'Médio',
          recipe_type: recipe_type, cuisine: cuisine,
          cook_time: 50,
          ingredients: 'Farinha, açucar, cenoura',
          cook_method: 'Cozinhe a cenoura, corte em  pedaços pequenos, misture com o restante dos ingredientes',
          user: user)
    list = List.create!(name: 'Lista Teste', user: user)
    
    login_as(user, scope: :user)
    visit recipe_path recipe
    select 'Lista Teste', from: 'Minhas Listas'
    click_on 'Adicionar na lista selecionada'

    expect(page).to have_content("#{recipe.title} foi adicionada na #{list.name}")
    expect(current_path).to eq(recipe_path recipe)
    expect(page).not_to have_css('option', text: list.name)
  end

end