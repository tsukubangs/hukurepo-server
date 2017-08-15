module V1
  class ProblemSerializer < ActiveModel::Serializer
    attributes :id, :comment, :image_url, :thumbnail_url, :latitude, :longitude, :user_id,
               :responded, :responses_seen, :created_at, :updated_at
    def thumbnail_url
      object.image_url(:thumb)
    end
  end
end
