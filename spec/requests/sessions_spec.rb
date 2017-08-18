require 'rails_helper'

describe 'Sessions', type: :request do
  let!(:user) { create(:user) }

  # sessions#create
  describe 'POST v1/login' do
    let(:params){ attributes_for(:user_login) }
    subject do
        post v1_login_path(format: :json), params, json_header
    end

    it 'login succeed if login params is correct' do
      subject

      expect(last_response).to be_ok
      expect(last_response.status).to eq(200)

      expect(json['user_id']).to eq(1)
      expect(json['email']).to eq('kaname@kaname.co.jp')
      expect(json['token_type']).to eq('Bearer')
    end

    it 'returns valid access_token if login params is correct' do
      subject
      header = {
        'HTTP_AUTHORIZATION' => json['access_token']
      }
      post v1_check_access_token_path, no_params, header
      expect(last_response.status).not_to eq(401)
      expect(json['message']).to eq('This access token is valid')
    end

    it 'returns authorization error(401) if access_token is invalid' do
      post v1_check_access_token_path, no_params, { 'HTTP_AUTHORIZATION' => 'invalid_access_token'}
      expect(last_response.status).to eq(401)
    end

    it 'returns authorization error(401) if access_token is invalid(contains id)' do
      post v1_check_access_token_path, no_params, { 'HTTP_AUTHORIZATION' => '1:Access_Token'}
      expect(last_response.status).to eq(401)
    end

    it 'returns authorization error(401) if email is not match' do
      params['email'] = 'notkaname@kaname.co.jp'
      post v1_login_path(format: :json), params, json_header
      expect(last_response.status).to eq(401)
      expect(json['error']).to eq('Login failed: Email or Password is wrong')
    end

    it 'returns authorization error(401) if password is not match' do
      params['password'] = 'notkaname'
      post v1_login_path(format: :json), params, json_header
      expect(last_response.status).to eq(401)
      expect(json['error']).to eq('Login failed: Email or Password is wrong')
    end

  end
end
