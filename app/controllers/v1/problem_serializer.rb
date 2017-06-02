module V1
  class ProblemSerializer < ActiveModel::Serializer
    attributes :id, :comment, :image_url, :latitude, :longitude, :user_id,
               :created_at, :updated_at
  end

  def image_url
    image.url
  end
end
