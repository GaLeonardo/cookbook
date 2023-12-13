require 'rails_helper'

feature 'Recipes API', type: :request  do
  context 'GET api/v1/recipes/:id' do
    scenario 'e recebe o conteúdo' do
      user = create(:user, email: 'user@email.com', password: '123456', role: :user)
      create(:recipe_type, name: 'Lanche')
      recipe = create(:recipe, user: user)

      get "/api/v1/recipes/#{recipe.id}"
      
      expect(response).to have_http_status(200)
    end
  end
end