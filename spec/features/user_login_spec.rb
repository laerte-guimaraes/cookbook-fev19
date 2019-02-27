require 'rails_helper'
feature 'User login' do

  scenario 'sucessfully' do
    test_email = 'email@quenaoexiste.com'
    User.create!(email: test_email, password: '12345678')

    visit root_path
    click_on 'Login'
    fill_in 'Email', with: test_email
    fill_in 'Password', with: '12345678'
    click_on 'Entrar'

    expect(current_path).to eq(root_path)
    expect(page).not_to have_content('Login')
    expect(page).to have_link('Logout')
    expect(page).to have_css('p', text: "Logado como #{test_email}.")
  end

end