class Problem < ApplicationRecord
  mount_uploader :image, ProblemPhotoUploader
  belongs_to :user, foreign_key: "user_id"
  has_many :responses, dependent: :destroy

  scope :responded, -> (value = true) { where(:responded => value) }
  scope :seen, -> (value = true) { where(:seen => value) }
  scope :by_response_priority, -> priority { where(:response_priority => priority.split(",")) }

  validates :response_priority, inclusion: { in: %w(high default low),
message: "allow only 'high' or 'default' or 'low'" }

### PROBLEM MODEL ###
  def self.new_problem(problem_params, user)
    problem = Problem.new(problem_params)
    problem.user = user
    problem.responses_seen = true # 返信がないときには既読フラグはtrue
    problem
  end

### ATTRIBUTES ###

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

  # 配列ではなくActiveRecordを返す
  def responded_users
    ActiveRecord::Base.transaction do
      user_ids = Response.where(problem_id: self.id).select(:user_id)
      User.where(id: user_ids)
    end
  end

  def is_response_necessary?
    return self.response_priority != 'low'
  end

### OTHER MODEL ###

  # 配列ではなくActiveRecordを返す
  def concerned_users
    ActiveRecord::Base.transaction do
      user_ids = Response.where(problem_id: self.id).select(:user_id)
      User.where(id: user_ids)
    end
  end

  def create_auto_response
    response_params = {
        comment: "Thank you for your contribution. The problem posted will be a reference for city improvement.",
        japanese_comment: "ご協力ありがとうございました。投稿された困りごとは都市改善の参考に致します。"
    }
    problem = self
    respondent = User.manager
    response = Response.new_response(response_params, respondent, self)
    response.save
  end
end
