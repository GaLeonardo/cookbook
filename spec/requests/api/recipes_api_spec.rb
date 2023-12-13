require 'rails_helper'

feature 'Recipes API', type: :request  do
  context 'GET api/v1/recipes/:id' do
    scenario 'e recebe o conteúdo' do
      user = create(:user, email: 'user@email.com', password: '123456', role: :user)
      create(:recipe_type, name: 'Lanche')
      recipe = create(:recipe, user: user)

      get "/api/v1/recipes/#{recipe.id}"
      
      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.class).to eq Hash
      expect(json_response.keys).to include 'title'
      expect(json_response.keys).to include 'ingredients'
      expect(json_response.keys).to include 'instructions'
      expect(json_response.keys).to include 'user_id'
    end

    scenario 'e recebe 404 por receita inexistente' do
      get "/api/v1/recipes/1"
      
      expect(response).to have_http_status(404)
      expect(response.content_type).to include 'application/json'

      json_response = JSON.parse(response.body)

      expect(json_response.keys).to include 'errors'
      expect(json_response['errors']).to eq 'Página não encontrada'
      expect(json_response.keys).not_to include 'title'
      expect(json_response.keys).not_to include 'ingredients'
      expect(json_response.keys).not_to include 'instructions'
      expect(json_response.keys).not_to include 'user_id'
    end
  end
end