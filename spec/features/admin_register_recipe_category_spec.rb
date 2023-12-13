require 'rails_helper'

feature 'Admin registra categoria de receita' do
  context 'criando categoria' do
    scenario 'com sucesso' do
      admin = create(:user, email: 'admin@email.com',
                            password: '123456', role: :admin)
  
      login_as admin, scope: :user
      visit new_recipe_category_path
      fill_in 'Nome', with: 'Happy Hour'
      click_on 'Salvar'

      expect(current_path).to eq recipe_category_path
      expect(page).to have_content 'Happy Hour'
      expect(page).to have_content 'Categoria de receita cadastrada com sucesso'
    end
  end
end