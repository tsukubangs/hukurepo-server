require 'rails_helper'

describe 'DeviceTokens', type: :request do
  let!(:user1) { create(:user1) }

  # device_controller#update
  describe 'put v1/users/me/device_token' do
    let(:params){ { device_token: 'test_device_token' } }
    subject do
      put me_device_token_v1_users_path(format: :json), params, authorization_header
    end
    
    context 'without authorization' do
      subject  { put me_device_token_v1_users_path(format: :json), params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      it 'update current_users device_token' do
        subject

        expect(last_response).to be_ok

        expect(json['device_token']).to eq('test_device_token')
      end

      it 'sweep other users same device_token' do
        # 同じデバイストークンを持つユーザと、違うデバイストークンを持つユーザを用意
        create(:user2, { device_token: user1.device_token})
        create(:user3, { device_token: 'other_device_token'})

        subject
        expect(User.first.device_token).to eq('test_device_token')
        expect(User.second.device_token).to be nil
        expect(User.third.device_token).to eq('other_device_token')
      end
    end
  end
end
