require 'rails_helper'
require 'uri'
require 'net/http'

describe 'Problems', type: :request do
  describe 'POST v1/problems' do
    let(:params){ {problem: FactoryGirl.attributes_for(:problem)} }
    subject do
        post v1_problems_path(format: :json), params
    end
  #
  #   context 'OK' do
  #     it 'increased problems' do
  #       expect { subject }.to change(Problem, :count).by(1)
  #     end
  #
  #     it 'respond 201(created)' do
  #       subject
  #       expect(last_response.status).to eq(201)
  #     end
  #
  #     it 'respond created problem' do
  #       subject
  #       expect(json['problem_id']).to eq(1)
  #     end
  #
  #     it 'respond accesstoken of can sign_in' do
  #       # TODO implments
  #     end
  #   end
  #
  #   context 'NG' do
  #     it 'invalid id' do
  #
  #     end
  #   end
  #
  end

  # problems#show
  describe 'GET /problems/:id' do
    before do
      create(:user)
    end

    let(:problem) do
      FactoryGirl.create(:problem)
    end

    context 'with authorization' do
      login
      subject do
        get v1_problem_path(problem.id, format: :json), no_params, authorization_header
      end
      context 'OK' do
        it 'returns 200(OK)' do
          subject
          # p last_request.env
          expect(last_response).to be_ok
        end
        it 'returns expected data' do
          subject
          expect(json['comment']).to eq('SOX is difficult')
          expath = 'uploads/problem/image/'+problem.id.to_s
          expect(json['image_url']).to match(expath)
          expect(json['image_url']).to match(/.+jpg/)
          expect(json['latitude']).to eq(36.10830528664971)
          expect(json['longitude']).to eq(140.10114337330694)
          expect(json['user_id']).to eq(1)
        end
      end
      context 'NG' do
        it 'returns 404 if user not found' do
          get v1_problem_path(-1, format: :json), no_params, authorization_header
          p last_response
          expect(last_response.status).to eq(404)
        end
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
