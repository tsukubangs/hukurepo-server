class Response < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    belongs_to :problem, foreign_key: "problem_id"
    
    def self.new_response(response_params, user, problem)
      ActiveRecord::Base.transaction do
        response = Response.new(response_params)
        response.user = user

        problem.touch
        # 困りごと投稿ユーザと別人が投稿したときに回答済みフラグrespondedをtrueにする
        # 困りごとユーザが返信したら再度回答する必要があるため、respondedをfalseにする
        if response.user != problem.user
          problem.responded = true
          problem.responses_seen = false # 回答があったら未読にする
        else
          problem.responded = false
          problem.responses_seen = true # 自分自身で回答したときは、返信を読んだこととする
        end
        problem.save!

        response.problem = problem

        response
      end
    end
end
