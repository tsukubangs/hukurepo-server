require 'rails_helper'

describe 'Users', type: :request do
  # users#create
  describe 'POST v1/users' do
    let(:params){ { user: attributes_for(:user) } }
    subject do
        post v1_users_path(format: :json), params
    end

    it 'creates user' do
      expect { subject }.to change(User, :count).by(1)

      expect(last_response.status).to eq(201)

      expect(json['user_id']).to eq(1)
      expect(json['email']).to eq('kaname@kaname.co.jp')
      expect(json['token_type']).to eq('Bearer')
    end

    it 'respond accesstoken of can sign_in' do
      subject
      header = {
        'HTTP_AUTHORIZATION' => json['access_token']
      }
      get v1_users_path, no_params, header
      expect(last_response).to be_ok
    end

    context 'when have validation error' do
      def user_attributes_for params
        { user: attributes_for(:user ,params) }
      end

      it 'returns 422(unprocessable entity) if params have already registered email' do
        subject
        # 既に登録されているユーザと同じ内容でpost
        post v1_users_path(format: :json), params
        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Email has already been taken')
      end

      it 'returns 422(unprocessable entity) if params have invalid email' do
        invalid_email = 'email@email'
        post v1_users_path(format: :json), user_attributes_for({ email: invalid_email})

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Email is invalid')
      end

      it 'returns 422(unprocessable entity) if params have too short password(under 6)' do
        invalid_password = 'kanam' # 5length
        post v1_users_path(format: :json), user_attributes_for({ password: invalid_password })

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Password is too short (minimum is 6 characters)')
      end

      it 'returns 422(unprocessable entity) if params have too long password(above 29)' do
        invalid_password = 'kanamekanamekanamekanamekanamekanamekanamekanamekanamekaname' # 30length
        post v1_users_path(format: :json), user_attributes_for({ password: invalid_password })

        expect(last_response.status).to eq(422)
        expect(json['error']).to eq('Validation failed: Password is too long (maximum is 30 characters)')
      end
    end
  end

  # users#index
  describe 'GET /users' do
    let(:user) { first_user }
    before do
      user
      create(:user_tama)
    end

    context 'without authorization' do
      subject do
        get v1_users_path(format: :json), no_params
      end

      it 'returns authorization error(401)' do
        subject
        expect(last_response.status).to eq(401)
        expect(json['error']).to eq(authenticate_error_message)
      end
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
        expect(json[0]['email']).to eq('kaname@kaname.co.jp')
        expect(json[0]['gender']).to eq('male')
        expect(json[0]['age']).to eq(20)
        expect(json[0]['nationality']).to eq('Japan')

        expect(json[1]['id']).to eq(2)
        expect(json[1]['email']).to eq('tama@tama.co.jp')
        expect(json[1]['gender']).to eq('female')
        expect(json[1]['age']).to eq(50)
        expect(json[1]['nationality']).to eq('Japan')
      end
    end
  end

  # users#show
  describe 'GET /users/:id' do
    let(:user) { first_user }

    context 'without authorization' do
      subject do
        get v1_user_path(user.id, format: :json), no_params
      end

      it 'returns authorization error(401)' do
        subject
        expect(last_response.status).to eq(401)
        expect(json['error']).to eq(authenticate_error_message)
      end
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
        expect(json['email']).to eq('kaname@kaname.co.jp')
        expect(json['gender']).to eq('male')
        expect(json['age']).to eq(20)
        expect(json['nationality']).to eq('Japan')
      end

      it 'returns 404 if problem is not exist' do
        not_exist_user_id = -1
        get v1_user_path(not_exist_user_id, format: :json), no_params, authorization_header

        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find User with 'id'=" + not_exist_user_id.to_s)
      end
    end
  end
end
