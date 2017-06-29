require 'rails_helper'

describe 'Users', type: :request do
  describe 'POST v1/users' do
    let(:params){ {user: FactoryGirl.attributes_for(:user)} }
    subject do
        post v1_users_path(format: :json), params
    end

    context 'OK' do
      it 'increased user' do
        expect { subject }.to change(User, :count).by(1)
      end

      it 'respond 201(created)' do
        subject
        expect(last_response.status).to eq(201)
      end

      it 'respond created user' do
        subject
        expect(json['user_id']).to eq(1)
        expect(json['email']).to eq('kaname@kaname.co.jp')
        expect(json['token_type']).to eq('Bearer')
        # トークンの最初に
      end

      it 'respond accesstoken of can sign_in' do
        # TODO implments
      end
    end

    context 'NG' do

    end
  end

  describe 'GET /users' do
    context 'with authorization' do
      login
      subject do
        get v1_users_path(format: :json), no_params, authorization_header
      end
      context 'OK' do
        it 'respond 200(OK)' do
          subject
          expect(last_response).to be_ok
          expect(last_response.status).to eq(200)
        end
      end
    end
  end

end
