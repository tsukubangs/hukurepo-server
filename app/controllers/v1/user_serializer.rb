module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :gender, :age, :country_of_residence, :role,
               :created_at, :updated_at
  end
  class UserMeSerializer < ActiveModel::Serializer
    attributes :id, :gender, :age, :email, :country_of_residence, :role,
               :created_at, :updated_at
    end
end
