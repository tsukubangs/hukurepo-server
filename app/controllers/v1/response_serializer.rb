module V1
  class ResponseSerializer < ActiveModel::Serializer
    attributes :id, :comment, :problem_id, :user_id, :created_at, :updated_at

    def comment
      ERB::Util.html_escape(object.comment)
    end
  end
end
