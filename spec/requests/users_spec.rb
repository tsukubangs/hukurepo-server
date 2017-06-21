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
      end

      it 'respond accesstoken of can sign_in' do
        # TODO implments
      end
    end

    context 'NG' do
      it 'invalid id' do

      end
    end

  end

  describe 'GET /users/:id' do
    let(:user)  { FactoryGirl.create(:user) }

    context 'with valid id' do

    end
  end

end
