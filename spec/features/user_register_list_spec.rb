require 'rails_helper'

feature 'User register list' do
  scenario 'successfully' do
    user = User.create(email: 'email@teste.com', password: '12345678')
    login_as(user, scope: :user)

    visit root_path
    click_on 'Minhas Listas'
    click_on 'Criar lista'
    fill_in 'Nome', with: 'Lista de Natal'
    click_on 'Confirmar'

    expect(page).to have_link('Lista de Natal')
    expect(page).to have_link('Criar lista')
    expect(current_path).to eq(lists_path)
  end

end