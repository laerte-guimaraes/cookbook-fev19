require 'rails_helper'

feature 'User should not create a recipe' do
  scenario 'with cook time zero' do

    # simula a ação do usuário
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Feijoada'
    fill_in 'Tipo da Receita', with: 'Prato Pesado'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Médio'
    fill_in 'Tempo de Preparo', with: '0'
    fill_in 'Ingredientes', with: 'Feijão, Carne de porco, Bacon'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'

    expect(page).to have_css('p', text: 'O tempo de preparo não pode ser igual a 0 (zero)!')
    expect(Recipe.count).to eq(0)
    expect(current_path).to eq(recipes_path)
  end

  scenario 'with negative cook time' do
   
    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Pastel'
    fill_in 'Tipo da Receita', with: 'Fritura'
    fill_in 'Cozinha', with: 'Brasileira'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '-10'
    fill_in 'Ingredientes', with: 'Massa e alguma outra coisa'
    fill_in 'Como Preparar', with: 'Coloque a outra coisa na massa e frite no óleo.'
    click_on 'Enviar'

    expect(page).to have_css('p', text: 'O tempo de preparo não pode ser negativo!')
    expect(Recipe.count).to eq(0)
   
  end

end