class Problem < ApplicationRecord
  mount_uploader :image, ProblemPhotoUploader
  belongs_to :user, foreign_key: "user_id"
  has_many :responses
end
