require 'rails_helper'

# Responseはファーストユーザがセカンドユーザに対してコメントする

describe 'Responses', type: :request do
  let!(:user1) { first_user }
  let!(:user2) { second_user }

  # responses#index
  describe 'GET /v1/problems/:problem_id/responses' do
    before do
    create(:response)
    create(:response2)
    end

    context 'with authorization' do
      login
      subject do
        get v1_problem_response_path(problem_id: format: :json), no_params, authorization_header
      end

      it 'returns existing response' do
        subject
        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect
      end
    end

  end

  # problems#show
  describe 'GET /problems/:problem_id/responses/:id' do
    let(:response){ create(:response) }

    context 'without authorization' do
      subject  { get v1_problem_response_path(problem_id: response.problem.id, id: response.id, format: :json) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_problem_response_path(problem_id: response.problem.id, id: response.id, format: :json), no_params, authorization_header
      end

      it 'returns exisiting response' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['id']).to eq(response.id)
        expect(json['comment']).to eq('Please go to the Tsukuba Center')
        expect(json['problem_id']).to eq(response.problem.id)
        expect(json['user_id']).to eq(first_user.id)
      end

      it 'returns 404 if response does not exist' do
        not_exist_response_id = -1
        not_exist_problem_id = -1
        get v1_problem_response_path(problem_id: not_exist_problem_id, id: not_exist_response_id, format: :json), no_params, authorization_header
        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find Response with 'id'=" + not_exist_response_id.to_s)
      end
    end
  end
end
