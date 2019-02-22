require 'rails_helper'

feature 'Admin register Cuisine' do
  
  scenario 'successfully' do
   
    visit root_path
    click_on 'Cadastrar uma cozinha'

    expect(page).to have_css('h1', text: 'Cadastro de Cozinhas')

    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_css('h1', text: 'Brasileira')
  end

  scenario 'without name param' do
    visit root_path
    click_on 'Cadastrar uma cozinha'
    click_on 'Enviar'
    
    expect(page).to have_content('Não foi possível salvar a cozinha')
    expect(page).to have_content('Você deve informar o nome da cozinha')
    expect(Cuisine.count).to eq(0)
  end

  scenario 'with repeated name' do
  
    visit root_path
    click_on 'Cadastrar uma cozinha'
    
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    visit root_path
    click_on 'Cadastrar uma cozinha'
    
    fill_in 'Nome', with: 'Brasileira'
    click_on 'Enviar'

    expect(page).to have_content('Não foi possível salvar a cozinha')
    expect(page).to have_content('Você não pode repetir o nome de uma cozinha')
    expect(Cuisine.count).to eq(1)

  end

end