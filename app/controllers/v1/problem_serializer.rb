module V1
  class ProblemSerializer < ActiveModel::Serializer
    attributes :id, :comment, :image_url, :latitude, :longitude, :user_id,
               :responses_seen, :created_at, :updated_at
  end
end
