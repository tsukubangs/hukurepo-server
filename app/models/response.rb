class Response < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    belongs_to :problem, foreign_key: "problem_id"

    def self.new_response(response_params, user, problem)
      response = Response.new(response_params)
      response.user = user

      problem.touch
      # 困りごと投稿ユーザと別人が投稿したときにrespondedをtrueにする
      # 困りごとユーザが投稿したらrespondedをfalseにする
      problem.responded = (user != problem.user)
      problem.save!

      response.problem = problem
      
      response
    end
end
