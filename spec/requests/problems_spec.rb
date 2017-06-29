require 'rails_helper'

describe 'Problems', type: :request do
  describe 'POST v1/problems' do
    let(:params){ { problem: attributes_for(:problem) } }

    context 'without authorization' do
      subject do
          post v1_problems_path(format: :json), params, {'Content-Type' => 'multipart/form-data'}
      end

      it 'returns authorization error(401)' do
        subject
        expect(last_response.status).to eq(401)
      end
    end

    context 'with authorization' do
      login
      subject do
          post v1_problems_path(format: :json), params, formdata_headers
      end

      it 'creates problem' do
        expect { subject }.to change(Problem, :count).by(1)

        expect(last_response.status).to eq(201)

        expect(json['id']).to eq(1)
        expect(json['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'+'1'
        expect(json['image_url']).to match(expath)
        expect(json['image_url']).to match(/.+jpg/)
        expect(json['latitude']).to eq(36.10830528664971)
        expect(json['longitude']).to eq(140.10114337330694)
        expect(json['user_id']).to eq(1)
      end
    end
  end

  # problems#show
  describe 'GET /problems/:id' do
    before { create(:user) }
    let(:problem){ create(:problem) }

    context 'with authorization' do
      login
      subject do
        get v1_problem_path(problem.id, format: :json), no_params, authorization_header
      end

      it 'returns exisiting problem' do
        subject
        
        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'+problem.id.to_s
        expect(json['image_url']).to match(expath)
        expect(json['image_url']).to match(/.+jpg/)
        expect(json['latitude']).to eq(36.10830528664971)
        expect(json['longitude']).to eq(140.10114337330694)
        expect(json['user_id']).to eq(1)
      end

    it 'returns 404 if user not found' do
      get v1_problem_path(-1, format: :json), no_params, authorization_header
      expect(last_response.status).to eq(404)
    end

    end

    context 'without authorization' do
      subject do
        get v1_problems_path(problem.id, format: :json)
      end
      it 'returns 401' do
        subject
        expect(last_response.status).to eq(401)
      end
    end
  end
end
