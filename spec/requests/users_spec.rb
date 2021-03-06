require 'rails_helper'

describe 'Users', type: :request do
  # users#create
  describe 'POST v1/users' do
    let(:params){ { user: attributes_for(:user) } }
    subject do
        post v1_users_path(format: :json), params, json_header
    end

    it 'creates user' do
      expect { subject }.to change(User, :count).by(1)

      expect(last_response.status).to eq(201)

      expect(json['user_id']).to eq(1)
      expect(json['email']).to eq('kaname@kaname.co.jp')
      expect(json['token_type']).to eq('Bearer')
    end

    it 'returns valid access_token' do
      subject
      header = {
        'HTTP_AUTHORIZATION' => json['access_token']
      }
      post v1_check_access_token_path, no_params, header
      expect(last_response.status).not_to eq(401)
    end

    context 'when it has validation error' do
      def user_attributes_for params
        { user: attributes_for(:user ,params) }
      end

      it 'returns 422(unprocessable entity) if email has been already registered' do
        subject
        # 既に登録されているユーザと同じ内容でpost
        post v1_users_path(format: :json), params
        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Email has already been taken')
      end

      it 'returns 422(unprocessable entity) if email as invalid' do
        invalid_email = 'email@email'
        post v1_users_path(format: :json), user_attributes_for({ email: invalid_email})

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Email is invalid')
      end

      it 'returns 422(unprocessable entity) if the password is too short (under 6)' do
        invalid_password = 'kanam' # 5length
        post v1_users_path(format: :json), user_attributes_for({ password: invalid_password }), json_header

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Password is too short (minimum is 6 characters)')
      end

      it 'returns 422(unprocessable entity) if password is too long(above 29)' do
        invalid_password = 'kaname'* 5 + 'k' # 31length
        post v1_users_path(format: :json), user_attributes_for({ password: invalid_password }), json_header

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Password is too long (maximum is 30 characters)')
      end

      it 'returns 422(unprocessable entity) if role is not allowed' do
        invalid_role = "manager"
        post v1_users_path(format: :json), user_attributes_for({ role: invalid_role }), json_header

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq("Validation failed: Role allow only 'poster' or 'respondent' or 'other'")
      end
    end
  end

  # users#index
  describe 'GET /users' do
    before do
      create(:user1)
      create(:user2)
    end

    context 'without authorization' do
      subject  { get v1_users_path(format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_users_path(format: :json), no_params, authorization_header
      end

      it 'returns existing users' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(1)
        expect(json[0]['gender']).to eq('male')
        expect(json[0]['age']).to eq(20)
        expect(json[0]['country_of_residence']).to eq('Japan')
        expect(json[0]['role']).to eq('poster')

        expect(json[1]['id']).to eq(2)
        expect(json[1]['gender']).to eq('female')
        expect(json[1]['age']).to eq(50)
        expect(json[1]['country_of_residence']).to eq('Japan')
        expect(json[1]['role']).to eq('respondent')
      end
    end
  end

  # users#me
  describe 'GET /users/me' do
    let!(:user) { create(:user) }

    context 'without authorization' do
      subject  { get me_v1_users_path(user.id, format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get me_v1_users_path(user.id, format: :json), no_params, authorization_header
      end

      it 'returns exisiting user' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['id']).to eq(user.id)
        expect(json['gender']).to eq('male')
        expect(json['age']).to eq(20)
        expect(json['country_of_residence']).to eq('Japan')
        expect(json['role']).to eq('poster')
        expect(json['email']).to eq('kaname@kaname.co.jp')
      end
    end
  end

  # users#show
  describe 'GET /users/:id' do
    let!(:user) { create(:user) }

    context 'without authorization' do
      subject  { get v1_user_path(user.id, format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_user_path(user.id, format: :json), no_params, authorization_header
      end

      it 'returns exisiting user' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['id']).to eq(user.id)
        expect(json['gender']).to eq('male')
        expect(json['age']).to eq(20)
        expect(json['country_of_residence']).to eq('Japan')
        expect(json['role']).to eq('poster')
      end

      it_behaves_like 'returns datetime'

      it 'returns 404 if problem does not exist' do
        not_exist_user_id = -1
        get v1_user_path(not_exist_user_id, format: :json), no_params, authorization_header

        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find User with 'id'=" + not_exist_user_id.to_s)
      end
    end
  end
end
