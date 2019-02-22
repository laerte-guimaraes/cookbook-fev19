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

    expect(page).to have_content('Você deve informar o nome da cozinha')
    expect(Cuisine.count).to eq(0)
  end

end