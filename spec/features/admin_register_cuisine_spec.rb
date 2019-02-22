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

end