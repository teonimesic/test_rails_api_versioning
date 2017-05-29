require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user_attrs) do
    {
      name: 'stefano',
      email: 'stefano@heavenstudio.com.br',
      picture: 'something'
    }
  end
  before { User.create(user_attrs) }

  describe 'GET /api/v1/users' do
    it 'returns 200' do
      get '/api/v1/users'
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(200)
    end

    it 'returns 200' do
      get '/api/v1/users'
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json.size).to eq 1
      expect(json[0].slice(*user_attrs.keys)).to eq(user_attrs)
    end
  end
end
