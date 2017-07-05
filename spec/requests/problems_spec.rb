require 'rails_helper'

describe 'Problems', type: :request, autodoc: true do
  let!(:user1) { create(:user1) }
  let!(:user2) { create(:user2) }

  # problems#create
  describe 'POST v1/problems' do
    let(:params){ { problem: attributes_for(:problem) } }

    context 'without authorization' do
      subject  { post v1_problems_path, params, {'Content-Type' => 'multipart/form-data'} }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
          post v1_problems_path(format: :json), params, formdata_header
      end

      it 'creates problem' do
        expect { subject }.to change(Problem, :count).by(1)

        expect(last_response.status).to eq(201)

        expect(json['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/' + json['id'].to_s
        expect(json['image_url']).to match(expath)
        expect(json['image_url']).to match(/.+jpg/)
        expect(json['latitude']).to eq(36.10830528664971)
        expect(json['longitude']).to eq(140.10114337330694)
        expect(json['user_id']).to eq(1)
      end
    end
  end

  # problems#index
  describe 'GET /problems' do

    before do
      create(:problem1, {user: user1})
      create(:problem2, {user: user2})
    end

    context 'without authorization' do
      subject  { get v1_problems_path(format: :json), no_params }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_problems_path(format: :json), no_params, authorization_header
      end

      it 'returns existing problems' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(1)
        expect(json[0]['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'
        expect(json[0]['image_url']).to match(expath)
        expect(json[0]['image_url']).to match(/.+jpg/)
        expect(json[0]['latitude']).to eq(36.10830528664971)
        expect(json[0]['longitude']).to eq(140.10114337330694)
        expect(json[0]['user_id']).to eq(1)

        expect(json[1]['id']).to eq(2)
        expect(json[1]['comment']).to eq('Where is Bus stop?')
        expath = 'uploads/problem/image/'
        expect(json[1]['image_url']).to match(expath)
        expect(json[1]['image_url']).to match(/.+jpg/)
        expect(json[1]['latitude']).to eq(36.10830528664373)
        expect(json[1]['longitude']).to eq(140.10114337330311)
        expect(json[1]['user_id']).to eq(2)
      end
    end
  end

  # problems#show
  describe 'GET /problems/:id' do
    let!(:problem){ create(:problem, {user: user1}) }

    context 'without authorization' do
      subject  { get v1_problem_path(problem.id, format: :json) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get v1_problem_path(problem.id, format: :json), no_params, authorization_header
      end

      it 'returns exisiting problem' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['id']).to eq(problem.id)
        expect(json['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'+problem.id.to_s
        expect(json['image_url']).to match(expath)
        expect(json['image_url']).to match(/.+jpg/)
        expect(json['latitude']).to eq(36.10830528664971)
        expect(json['longitude']).to eq(140.10114337330694)
        expect(json['user_id']).to eq(problem.user.id)
      end

      it 'returns 404 if user does not exist' do
        not_exist_problem_id = -1
        get v1_problem_path(not_exist_problem_id, format: :json), no_params, authorization_header

        expect(last_response.status).to eq(404)
        expect(json['error']).to eq("Couldn't find Problem with 'id'=" + not_exist_problem_id.to_s)
      end
    end
  end

  # problems#me and problems$users
  describe 'GET /problems/me' do
    before do
      create(:problem1, {user: user1})
      create(:problem2, {user: user2})
      create(:problem3, {user: user1})
    end

    context 'without authorization' do
      subject  { get me_v1_problems_path(format: :json) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get me_v1_problems_path(format: :json), no_params, authorization_header
      end

      it 'returns first_users problem' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(1)
        expect(json[0]['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'
        expect(json[0]['image_url']).to match(expath)
        expect(json[0]['image_url']).to match(/.+jpg/)
        expect(json[0]['latitude']).to eq(36.10830528664971)
        expect(json[0]['longitude']).to eq(140.10114337330694)
        expect(json[0]['user_id']).to eq(1) # important!

        expect(json[1]['id']).to eq(3)
        expect(json[1]['comment']).to eq('Bicycle is too many!!!')
        expath = 'uploads/problem/image/'
        expect(json[1]['image_url']).to match(expath)
        expect(json[1]['image_url']).to match(/.+jpg/)
        expect(json[1]['latitude']).to eq(36.1181461)
        expect(json[1]['longitude']).to eq(140.0903428)
        expect(json[1]['user_id']).to eq(1) # important!
      end
    end
  end
end