class Problem < ApplicationRecord
  mount_uploader :image, ProblemPhotoUploader
  belongs_to :user, foreign_key: "user_id"
  has_many :responses, dependent: :destroy

  scope :responded, -> (value = true) { where(:responded => value) }
  scope :seen, -> (value = true) { where(:seen => value) }

  # 回答がきたときにproblemの状態（返信済み、回答既読）を更新する
  # 困りごと投稿ユーザと別人が投稿したときに回答済みフラグrespondedをtrueにする
  # 困りごとユーザが返信したら再度回答する必要があるため、respondedをfalseにする
  def update_response_status(response)
    if response.user != self.user
      self.responded = true
      self.responses_seen = false # 回答があったら未読にする
    else
      self.responded = false
      self.responses_seen = true # 自分自身で回答したときは、返信を読んだこととする
    end
    self.save
  end

  def responded_users
    ActiveRecord::Base.transaction do
      user_ids = Response.where(problem_id: self.id).select(:user_id)
      User.where(id: user_ids)
    end
  end

  def concerned users
    ActiveRecord::Base.transaction do
      user_ids = Response.where(problem_id: self.id).select(:user_id)
      User.where(id: user_ids)
    end
  end
end
