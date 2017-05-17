class Problem < ApplicationRecord
  mount_uploader :image, ProblemPhotoUploader
end
