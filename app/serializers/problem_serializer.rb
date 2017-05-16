class ProblemSerializer < ActiveModel::Serializer
  attributes :id, :comment, :image, :latitude, :longitude

end
