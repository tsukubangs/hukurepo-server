require 'rails_helper'

# Response:2番目のユーザが投稿した２番目のproblemに対して，1番目のuserがコメント（返答）をする

describe 'Responses', type: :request do
  let!(:user1) { create(:user1) }
  let!(:user2) { create(:user2) }
  let!(:user3) { create(:user3) }
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

      it 'updated problem status' do
        before_updated_at = problem2.updated_at

        subject

        after_problem2 = Problem.find(problem2.id)
        expect(after_problem2.updated_at).not_to eq before_updated_at
        expect(after_problem2.responded).to be_truthy
        expect(after_problem2.responses_seen).to be_falsey
      end

      it 'updated problem status when responses by problem owner' do
        before_updated_at = problem1.updated_at

        post v1_problem_responses_path(problem1.id, format: :json), params, authorization_header

        after_problem1 = Problem.find(problem1.id)
        expect(after_problem1.updated_at).not_to eq before_updated_at
        expect(after_problem1.responded).to be_falsey
        expect(after_problem1.responses_seen).to be_truthy
      end

      it 'returns 404 if problem does not exist' do
        not_exist_problem_id = -1
        post v1_problem_responses_path(not_exist_problem_id, format: :json), params, authorization_header
        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find Problem with 'id'=" + not_exist_problem_id.to_s)
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

  # responses#show
  describe 'GET /responses/:id' do
    let!(:response){ create(:response1, {user: user1, problem: problem2}) }

    context 'without authorization' do
      subject  { get v1_response_path(id: response.id, format: :json) }
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

  # responses#destroy
  describe 'DELETE /responses/:id' do
    let!(:response1) { create(:response1, {user: user1, problem: problem2}) }
    let!(:response2) { create(:response2, {user: user2, problem: problem1}) }
    let!(:response3) { create(:response3, {user: user3, problem: problem2}) }

    context 'without authorization' do
      subject  { delete v1_response_path(id: response1.id) }
      it_behaves_like 'returns 401'
    end

    # 困りごとの投稿者と、返信の投稿者が返信を消すことができる
    context 'with authorization' do
      login
      subject do
        delete v1_response_path(id: response1.id), no_params, authorization_header
      end

      # responseの投稿者のとき
      it 'returns 204 if response owner' do
        expect { subject }.to change(Response, :count).from(3).to(2)
        expect(last_response.status).to eq(204)
      end

      # problemの投稿者のとき消える
      it 'returns 204 if problem owner' do
        before_count = Response.count
        delete v1_response_path(id: response2.id), no_params, authorization_header
        after_count = Response.count

        expect( (after_count - before_count) ).to eq(-1)
        expect(last_response.status).to eq(204)
      end

      # prolem, responseの投稿者じゃないとき
      it 'returns 403 if not problem/response owner' do
        before_count = Response.count
        delete v1_response_path(id: response3.id), no_params, authorization_header
        after_count = Response.count

        expect(after_count).to eq(before_count)
        expect(last_response.status).to eq(403)
      end
    end
  end

  # responses#put_seen
  describe 'PUT v1/problems/:problem_id/responses/seen' do
    before do
      # user1が投稿したproblem1に対してuser2が回答
      create(:response1, {user: user2, problem: problem1})
      # user2が投稿したproblem2に対してuser1が回答
      create(:response2, {user: user1, problem: problem2})
    end

    context 'without authorization' do
      subject  { get seen_v1_problem_responses_path(problem_id: 1, format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        put seen_v1_problem_responses_path(problem_id: 1, format: :json),
            no_params, authorization_header
      end

      it 'change seen status to true by owner of the problem' do
        subject

        expect(last_response.status).to eq(200)
        expect(json['seen']).to be_truthy
      end

      it 'reject changing seen status by who are not owner of the problem' do
        put seen_v1_problem_responses_path(problem_id: 2, format: :json),
            no_params, authorization_header

        expect(last_response.status).to eq(403)
        expect(json['error']).to eq("Only owner of problem can change seen status.")
      end

    end
  end

  # responses#get_seen
  describe 'GET v1/problems/:problem_id/responses/seen' do
    login
    subject do
      get seen_v1_problem_responses_path(problem_id: 1, format: :json),
          no_params, authorization_header
    end

    it 'returns seen status' do
      subject

      expect(last_response.status).to eq(200)
      expect(json['seen']).to be_truthy
    end

    it 'returns changed seen status' do
      # 一度putした後getして変わったことを確かめる
      put seen_v1_problem_responses_path(problem_id: 1, format: :json),
          no_params, authorization_header

      subject

      expect(last_response.status).to eq(200)
      expect(json['seen']).to be_truthy
    end
  end
end
