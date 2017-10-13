require 'rails_helper'

describe 'Problems', type: :request do
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
        expect(json['thumbnail_url']).to match(expath + '/thumb')
        expect(json['thumbnail_url']).to match(/.+jpg/)
        expect(json['latitude']).to eq(36.10830528664971)
        expect(json['longitude']).to eq(140.10114337330694)
        expect(json['user_id']).to eq(1)
        expect(json['response_priority']).to eq("default")
        expect(json['responded']).to be false
        expect(json['responses_seen']).to be true
      end

      it_behaves_like 'returns datetime'

      it 'can access uploaded image' do
        subject
        get json['image_url'], no_params, authorization_header
        expect(last_response.status).to eq(200)
      end

      it 'can access thumbnail' do
        subject
        get json['thumbnail_url'], no_params, authorization_header
        expect(last_response.status).to eq(200)
      end

      context 'escape html tags of json response' do
        let(:params_script){ { problem: attributes_for(:problem_script) } }

        login
        subject do
            post v1_problems_path(format: :json), params_script, formdata_header
        end

        example 'script tag' do
          subject

          expect(last_response.status).to eq(201)

          expect(json['comment']).to eq('&lt;script&gt;alert(1)&lt;/script&gt;')
        end
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

      it 'returns existing problems(order desc)' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(2)
        expect(json[0]['comment']).to eq('Where is Bus stop?')
        expath = 'uploads/problem/image/'
        expect(json[0]['image_url']).to match(expath)
        expect(json[0]['image_url']).to match(/.+jpg/)
        expect(json[0]['thumbnail_url']).to match(expath + json[0]['id'].to_s + '/thumb')
        expect(json[0]['thumbnail_url']).to match(/.+jpg/)
        expect(json[0]['latitude']).to eq(36.10830528664373)
        expect(json[0]['longitude']).to eq(140.10114337330311)
        expect(json[0]['user_id']).to eq(2)
        expect(json[0]['response_priority']).to eq("high")
        expect(json[0]['responded']).to be false
        expect(json[0]['responses_seen']).to be true

        expect(json[1]['id']).to eq(1)
        expect(json[1]['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'
        expect(json[1]['image_url']).to match(expath)
        expect(json[1]['image_url']).to match(/.+jpg/)
        expect(json[1]['thumbnail_url']).to match(expath + json[1]['id'].to_s + '/thumb')
        expect(json[1]['thumbnail_url']).to match(/.+jpg/)
        expect(json[1]['latitude']).to eq(36.10830528664971)
        expect(json[1]['longitude']).to eq(140.10114337330694)
        expect(json[1]['user_id']).to eq(1)
        expect(json[1]['response_priority']).to eq("default")
        expect(json[1]['responded']).to be false
        expect(json[1]['responses_seen']).to be true
      end

      context 'with sort params' do
        before do
          # 3つ目のテストを追加
          create(:problem3, {user: user1})
        end

        example 'user_id(desc)' do
          params = { sort: '-user_id'} # user_idの降順
          get v1_problems_path(format: :json), params, authorization_header

          expect(json[0]['user_id']).to eq(2)
          expect(json[1]['user_id']).to eq(1)
          expect(json[2]['user_id']).to eq(1)
        end

        example 'responded(asc)' do
          params = { sort: 'responded'} # respondedの昇順(falseが先、trueが後)
          get v1_problems_path(format: :json), params, authorization_header

          expect(json[0]['responded']).to be false
          expect(json[1]['responded']).to be false
          expect(json[2]['responded']).to be true
        end

        example 'responded(desc), user_id(asc)' do
          params = { sort: 'user_id, -responded'} #  user_idを昇順でソート→repondedの降順（trueが先)でソート
          get v1_problems_path(format: :json), params, authorization_header

          expect(json[0]['id']).to eq(3)
          expect(json[1]['id']).to eq(1)
          expect(json[2]['id']).to eq(2)
        end
      end

      context 'with scope params' do
        before do
          # 3つ目のテストを追加
          create(:problem3, {user: user1})
        end

        example 'by_response_priority' do
          params = { by_response_priority: "low" }
          get v1_problems_path(format: :json), params, authorization_header

          expect(json).to be_an Array
          expect(json.size).to eq(1)

          expect(json[0]['response_priority']).to eq("low")
        end
      end

      context 'valid pagenation' do
        before do
          # 7件困りごと追加（困りごとを9件用意）
          create_list(:problem1, 7, {user: user1})
        end

        it 'returns 5 problems on page1' do
           get v1_problems_path(format: :json), {page: 1}, authorization_header

           expect(last_response.status).to eq(200)
           expect(json).to be_an Array

           expect(json.size).to eq(5)
        end

        it 'returns 4 problems on page2' do
           get v1_problems_path(format: :json), {page: 2}, authorization_header

           expect(last_response.status).to eq(200)
           expect(json).to be_an Array

           expect(json.size).to eq(4)
        end
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
        expect(json['thumbnail_url']).to match(expath + '/thumb')
        expect(json['thumbnail_url']).to match(/.+jpg/)
        expect(json['latitude']).to eq(36.10830528664971)
        expect(json['longitude']).to eq(140.10114337330694)
        expect(json['user_id']).to eq(problem.user.id)
        expect(json['response_priority']).to eq("default")
        expect(json['responded']).to be false
        expect(json['responses_seen']).to be true
      end

      it_behaves_like 'returns datetime'

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

      it 'returns first_users problems(order desc)' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(3)
        expect(json[0]['comment']).to eq('Bicycle is too many!!!')
        expath = 'uploads/problem/image/'
        expect(json[0]['image_url']).to match(expath)
        expect(json[0]['image_url']).to match(/.+jpg/)
        expect(json[0]['thumbnail_url']).to match(expath + json[0]['id'].to_s + '/thumb')
        expect(json[0]['thumbnail_url']).to match(/.+jpg/)
        expect(json[0]['latitude']).to eq(36.1181461)
        expect(json[0]['longitude']).to eq(140.0903428)
        expect(json[0]['user_id']).to eq(1) # important!
        expect(json[0]['response_priority']).to eq("low")
        expect(json[0]['responded']).to be true

        expect(json[1]['id']).to eq(1)
        expect(json[1]['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'
        expect(json[1]['image_url']).to match(expath)
        expect(json[1]['image_url']).to match(/.+jpg/)
        expect(json[1]['thumbnail_url']).to match(expath + json[1]['id'].to_s + '/thumb')
        expect(json[1]['thumbnail_url']).to match(/.+jpg/)
        expect(json[1]['latitude']).to eq(36.10830528664971)
        expect(json[1]['longitude']).to eq(140.10114337330694)
        expect(json[1]['user_id']).to eq(1) # important!
        expect(json[1]['response_priority']).to eq("default")
        expect(json[1]['responded']).to be false
      end

      context 'with sort params' do
        before do
          # 4つ目のテストデータを追加
          create(:problem, {user: user1})
        end

        example 'id(asc)' do
          params = { sort: 'id'} # idの昇順
          get me_v1_problems_path(format: :json), params, authorization_header

          expect(json).to be_an Array

          expect(json[0]['id']).to eq(1)
          expect(json[1]['id']).to eq(3)
          expect(json[2]['id']).to eq(4)
        end
      end

      context 'valid pagenation' do
        before do
          # 7件困りごと追加（困りごとを9件用意）
          create_list(:problem1, 7, {user: user1})
        end

        it 'returns 5 problems on page1' do
           get me_v1_problems_path(format: :json), {page: 1}, authorization_header

           expect(last_response.status).to eq(200)
           expect(json).to be_an Array

           expect(json.size).to eq(5)
        end

        it 'returns 4 problems on page2' do
           get me_v1_problems_path(format: :json), {page: 2}, authorization_header

           expect(last_response.status).to eq(200)
           expect(json).to be_an Array

           expect(json.size).to eq(4)
        end
      end
    end
  end

  # problems#resonded
  describe 'GET /problems/responded' do
    before do
      problem1 = create(:problem1, {user: user1})
      problem2 = create(:problem2, {user: user2})
      problem3 = create(:problem3, {user: user2})

      # problem1,3にuser1が返答
      create(:response1, {user: user1, problem: problem1})
      create(:response2, {user: user2, problem: problem2})
      create(:response3, {user: user1, problem: problem3})
    end

    context 'without authorization' do
      subject  { get responded_v1_problems_path(format: :json) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get responded_v1_problems_path(format: :json), no_params, authorization_header
      end

      it 'returns problems that first_users responded' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json).to be_an Array

        expect(json[0]['id']).to eq(3)
        expect(json[0]['comment']).to eq('Bicycle is too many!!!')
        expath = 'uploads/problem/image/'
        expect(json[0]['image_url']).to match(expath)
        expect(json[0]['image_url']).to match(/.+jpg/)
        expect(json[0]['thumbnail_url']).to match(expath + json[0]['id'].to_s + '/thumb')
        expect(json[0]['thumbnail_url']).to match(/.+jpg/)
        expect(json[0]['latitude']).to eq(36.1181461)
        expect(json[0]['longitude']).to eq(140.0903428)
        expect(json[0]['user_id']).to eq(2)
        expect(json[0]['response_priority']).to eq("low")
        expect(json[0]['responded']).to be true

        expect(json[1]['id']).to eq(1)
        expect(json[1]['comment']).to eq('SOX is difficult')
        expath = 'uploads/problem/image/'
        expect(json[1]['image_url']).to match(expath)
        expect(json[1]['image_url']).to match(/.+jpg/)
        expect(json[1]['thumbnail_url']).to match(expath + json[1]['id'].to_s + '/thumb')
        expect(json[1]['thumbnail_url']).to match(/.+jpg/)
        expect(json[1]['latitude']).to eq(36.10830528664971)
        expect(json[1]['longitude']).to eq(140.10114337330694)
        expect(json[1]['user_id']).to eq(1)
        expect(json[1]['response_priority']).to eq("default")

        expect(json[1]['responded']).to be false
      end

      context 'with sort params' do
        before do
          # 4つ目のテストデータを追加
          problem4 = create(:problem, {user: user1})

          create(:response, {user: user1, problem: problem4})
        end

        example 'id(asc)' do
          params = { sort: 'id'} # idの昇順
          get responded_v1_problems_path(format: :json), params, authorization_header

          expect(json[0]['id']).to eq(1)
          expect(json[1]['id']).to eq(3)
          expect(json[2]['id']).to eq(4)
        end
      end
    end
  end

  # problems#me and problems$users
  describe 'GET /problems/me/count' do
    before do
      create(:problem1, {user: user1})
      create(:problem2, {user: user2})
      create(:problem3, {user: user1})
    end

    context 'without authorization' do
      subject  { get me_count_v1_problems_path(format: :json) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        get me_count_v1_problems_path(format: :json), no_params, authorization_header
      end

      it 'returns count of first_users problems' do
        subject

        expect(last_response).to be_ok
        expect(last_response.status).to eq(200)

        expect(json['count']).to eq(2)
      end
    end
  end

  # problems#destroy
  describe 'DELETE /problems/:id' do
    let!(:problem1){ create(:problem1, {user: user1}) }
    let!(:problem2){ create(:problem2, {user: user2}) }

    context 'without authorization' do
      subject  { delete v1_problem_path(problem1.id) }
      it_behaves_like 'returns 401'
    end

    context 'with authorization' do
      login
      subject do
        delete v1_problem_path(problem1.id), no_params, authorization_header
      end

      it 'returns 204' do
        expect { subject }.to change(Problem, :count).from(2).to(1)
        expect(last_response.status).to eq(204)
      end

      it 'return 403 if user is not owner of problem' do
        before_count = Problem.count
        delete v1_problem_path(problem2.id), no_params, authorization_header
        after_count = Problem.count

        expect(after_count).to eq(before_count)
        expect(last_response.status).to eq(403)
      end
    end
  end
end
