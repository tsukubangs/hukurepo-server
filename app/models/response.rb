class Response < ApplicationRecord
    belongs_to :user, foreign_key: "user_id"
    belongs_to :problem, foreign_key: "problem_id"
end
