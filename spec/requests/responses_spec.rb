require 'rails_helper'

# Response:2番目のユーザが投稿した２番目のproblemに対して，1番目のuserがコメント（返答）をする

describe 'Responses', type: :request do
  let!(:user1) { first_user }
  let!(:user2) { second_user }
  let!(:problem1) { create(:problem1) }
  let!(:problem2) { create(:problem2) }

  # responses#create
  describe 'POST v1/problems/:problem_id/responses' do
    let(:params){ { response: attributes_for(:response1_to_problem2) } }

    context 'without authorization' do
      subject {post v1_problem_responses_path(problem2.id, format: :json), params}
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        post v1_problem_responses_path(problem2.id, format: :json), params, authorization_header
      end

      it 'creates responses' do
        expect { subject }.to change(Response, :count).by(1)

        expect(last_response.status).to eq(201)

        expect(json['id']).to eq(1)
        expect(json['comment']).to eq('Please go to the Tsukuba Center')
        expect(json['problem_id']).to eq(2)
        expect(json['user_id']).to eq(1)
      end
    end
  end

  # responses#index
  describe 'GET /v1/problems/:problem_id/responses' do
    let!(:response1_to_problem2){ create(:response1_to_problem2)}
    let!(:response1_to_problem1){ create(:response1_to_problem1)}
    let!(:response2_to_problem2){ create(:response2_to_problem2)}

    context 'without authorization' do
      subject  { get v1_problem_responses_path(problem_id: 2, format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_problem_responses_path(problem_id: 2, format: :json), no_params, authorization_header
      end

      it 'returns existing responses' do
        subject
        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(1)
        expect(json[0]['comment']).to eq('Please go to the Tsukuba Center')
        expect(json[0]['problem_id']).to eq(2)
        expect(json[0]['user_id']).to eq(1)

        #response2はproblem1に対する返答のため，ここでは返されない

        expect(json[1]['id']).to eq(3)
        expect(json[1]['comment']).to eq('Please go to Daigaku Kaikan Mae')
        expect(json[1]['problem_id']).to eq(2)
        expect(json[1]['user_id']).to eq(1)
      end
    end
  end

  # problems#show
  describe 'GET /responses/:id' do
    let(:response){ create(:response1_to_problem2) }

    context 'without authorization' do
      subject  { get v1_response_path(problem_id: response.problem.id, id: response.id, format: :json) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_response_path(id: response.id, format: :json), no_params, authorization_header
      end

      it 'returns exisiting response' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['id']).to eq(response.id)
        expect(json['comment']).to eq('Please go to the Tsukuba Center')
        expect(json['problem_id']).to eq(response.problem.id)
        expect(json['user_id']).to eq(user1.id)
      end

      it 'returns 404 if response does not exist' do
        not_exist_response_id = -1
        get v1_response_path(id: not_exist_response_id, format: :json), no_params, authorization_header
        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find Response with 'id'=" + not_exist_response_id.to_s)
      end
    end
  end
end
