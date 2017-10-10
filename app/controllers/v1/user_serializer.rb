module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :name, :gender, :age, :country_of_residence, :image, :role,
               :created_at, :updated_at
  end
end
