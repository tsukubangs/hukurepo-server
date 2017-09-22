module V1
  class ResponseSerializer < ActiveModel::Serializer
    attributes :id, :comment, :japanese_comment, :problem_id, :user_id, :created_at, :updated_at

    def comment
      ERB::Util.html_escape(object.comment)
    end

    def japanese_comment
      ERB::Util.html_escape(object.japanese_comment)
    end
  end
end
