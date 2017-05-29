require 'rails_helper'
require 'pry'

RSpec.describe '/api/v2/users', type: :request do
  let(:user_attrs) do
    {
      name: 'stefano',
      email: 'stefano@heavenstudio.com.br',
      picture: 'something',
      gender: 'M'
    }
  end
  let(:invalid_user_attrs) { user_attrs.merge(name: '') }

  describe 'GET users' do
    before { User.create(user_attrs) }

    describe 'GET /api/v2/users' do
      it 'returns json' do
        get '/api/v2/users'
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end

      it 'returns 200' do
        get '/api/v2/users'
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data.size).to eq 1
        expect(data[0][:attributes].slice(*user_attrs.keys)).to eq(user_attrs)
      end
    end
  end

  describe 'GET user' do
    let!(:user) { User.create(user_attrs) }

    describe 'GET /api/v2/users/:id' do
      it 'returns json' do
        get "/api/v2/users/#{user.to_param}"
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end

      it 'returns 200' do
        get "/api/v2/users/#{user.to_param}"
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:attributes].slice(*user_attrs.keys)).to eq(user_attrs)
      end
    end
  end

  describe 'POST user' do
    context 'with valid attributes' do
      it 'returns json' do
        post '/api/v2/users', params: { user: user_attrs }
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(201)
      end

      it 'creates a new user' do
        expect do
          post '/api/v2/users', params: { user: user_attrs }
        end.to change{ User.count }.by(1)
      end

      it 'returns the new created user' do
        post '/api/v2/users', params: { user: user_attrs }
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:attributes].slice(*user_attrs.keys)).to eq(user_attrs)
        expect(data[:id]).to be_present
        expect(data[:errors]).to be_nil
      end
    end

    context 'with invalid attributes' do
      it 'returns json' do
        post '/api/v2/users', params: { user: invalid_user_attrs }
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(422)
      end

      it 'doesnt creates a new user' do
        expect do
          post '/api/v2/users', params: { user: invalid_user_attrs }
        end.not_to change { User.count }
      end

      it 'returns errors' do
        post '/api/v2/users', params: { user: invalid_user_attrs }
        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors[:name]).to eq ['can\'t be blank']
      end
    end
  end

  describe 'PATCH user' do
    let!(:user) { User.create(user_attrs) }
    let(:valid_user_attrs) { { name: 'new name' } }

    context 'with valid attributes' do
      it 'returns json' do
        patch "/api/v2/users/#{user.to_param}", params: { user: valid_user_attrs }
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(200)
      end

      it 'returns the changed user' do
        patch "/api/v2/users/#{user.to_param}", params: { user: valid_user_attrs }
        data = JSON.parse(response.body, symbolize_names: true)[:data]
        expect(data[:attributes][:name]).to eq 'new name'
        expect(data[:errors]).to be_nil
      end
    end

    context 'with invalid attributes' do
      let!(:user) { User.create(user_attrs) }
      let(:invalid_user_attrs) { { name: '' } }

      it 'returns json' do
        patch "/api/v2/users/#{user.to_param}", params: { user: invalid_user_attrs }
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(422)
      end

      it 'returns errors' do
        patch "/api/v2/users/#{user.to_param}", params: { user: invalid_user_attrs }
        errors = JSON.parse(response.body, symbolize_names: true)[:errors]
        expect(errors[:name]).to eq ['can\'t be blank']
      end
    end
  end

  describe 'DELETE user' do
    let!(:user) { User.create(user_attrs) }

    describe 'GET /api/v2/users/:id' do
      it 'returns json' do
        delete "/api/v2/users/#{user.to_param}"
        expect(response).to have_http_status(200)
      end

      it 'removes the user from the database' do
        expect do
          delete "/api/v2/users/#{user.to_param}"
        end.to change { User.count }.by(-1)
      end
    end
  end
end
