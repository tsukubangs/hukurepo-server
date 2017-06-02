module V1
  class ProblemSerializer < ActiveModel::Serializer
    attributes :id, :comment, :image, :latitude, :longitude, :user_id,
               :created_at, :updated_at
  end
end
