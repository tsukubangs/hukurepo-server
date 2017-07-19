module V1
  class ProblemSerializer < ActiveModel::Serializer
    attributes :id, :comment, :image_url, :latitude, :longitude, :user_id,
               :responded, :responses_seen, :created_at, :updated_at
  end
end
