require 'rails_helper'

# Response:2番目のユーザが投稿した２番目のproblemに対して，1番目のuserがコメント（返答）をする

describe 'Responses', type: :request do
  let!(:user1) { create(:user1) }
  let!(:user2) { create(:user2) }
  let!(:problem1) { create(:problem1, {user: user1}) }
  let!(:problem2) { create(:problem2, {user: user2}) }

  # responses#create
  describe 'POST v1/problems/:problem_id/responses' do
    let(:params){ { response: attributes_for(:response, {user: user1, problem: problem2}) } }

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

      it_behaves_like 'returns datetime'

      it 'returns 422 if problem does not exist' do
        not_exist_problem_id = -1
        post v1_problem_responses_path(not_exist_problem_id, format: :json), params, authorization_header
        expect(last_response.status).to eq(422)
        expect(json['problem'][0]).to eq("must exist")
      end

    end
  end

  # responses#index
  describe 'GET /v1/problems/:problem_id/responses' do

    before do
      create(:response1, {user: user1, problem: problem2})
      create(:response2, {user: user2, problem: problem1})
      create(:response3, {user: user1, problem: problem2})
    end

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

      it 'returns 404 if problem does not exist' do
        not_exist_problem_id = -1
        get v1_problem_responses_path(not_exist_problem_id, format: :json), no_params, authorization_header
        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find Problem with 'id'=" + not_exist_problem_id.to_s)
      end

    end
  end

  # problems#show
  describe 'GET /responses/:id' do
    let!(:response){ create(:response1, {user: user1, problem: problem2}) }

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

      it_behaves_like 'returns datetime'

      it 'returns 404 if response does not exist' do
        not_exist_response_id = -1
        get v1_response_path(not_exist_response_id, format: :json), no_params, authorization_header
        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find Response with 'id'=" + not_exist_response_id.to_s)
      end
    end
  end

  # responses#put_seen
  describe 'POST v1/problems/:problem_id/responses/seen' do
    before do
      # user1が投稿したproblem1に対してuser2が回答
      create(:response2, {user: user2, problem: problem1})
    end

    context 'without authorization' do
      subject  { get seen_v1_problem_responses_path(problem_id: 1, format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get seen_v1_problem_responses_path(problem_id: 2, format: :json),
            no_params, authorization_header
      end


    end
  end

  # responses#get_seen
  describe 'GET v1/problems/:problem_id/responses/seen' do

  end

end
