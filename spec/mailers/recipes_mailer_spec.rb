require 'rails_helper'

RSpec.describe RecipesMailer do

  describe '.notify_new_recipe' do
    it 'should send a mail to admin' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user =  User.create!(email: 'test_email@mail.com', password: '12345678')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine,
        cook_time: 50,
        ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
        user: user)

      mail = RecipesMailer.notify_new_recipe(recipe.id)
      expect(mail.to).to include('admin@cookbook.com')      
    end

    it 'shoud have the correct subject' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user =  User.create!(email: 'test_email@mail.com', password: '12345678')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine,
        cook_time: 50,
        ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
        user: user)

        mail = RecipesMailer.notify_new_recipe(recipe.id)
        expect(mail.subject).to eq("Receita (#{recipe.title}) criada com sucesso!")    
    end

    it 'should have the correct content' do
      recipe_type = RecipeType.create(name: 'Sobremesa')
      cuisine = Cuisine.create(name: 'Brasileira')
      user =  User.create!(email: 'test_email@mail.com', password: '12345678')
      recipe = Recipe.create(title: 'Bolo de cenoura', difficulty: 'Médio',
        recipe_type: recipe_type, cuisine: cuisine,
        cook_time: 50,
        ingredients: 'Farinha, açucar, cenoura',
        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes',
        user: user)

        mail = RecipesMailer.notify_new_recipe(recipe.id)
        expect(mail.body).to include('Nova Receita cadastrada!')
        expect(mail.body).to include("#{recipe.title} criado por #{recipe.user.email}")
    end
  end

end