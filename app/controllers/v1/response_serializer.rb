module V1
  class ResponseSerializer < ActiveModel::Serializer
    attributes :id, :response, :problem_id, :user_id
  end
end
