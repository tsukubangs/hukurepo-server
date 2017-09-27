class Response < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    belongs_to :problem, foreign_key: "problem_id"

    def self.new_response(response_params, user, problem)
      ActiveRecord::Base.transaction do
        response = Response.new(response_params)
        response.user = user

        problem.update_response_status(response)
        response.problem = problem

        response
      end
    end
end
