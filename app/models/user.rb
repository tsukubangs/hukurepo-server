class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :update_access_token!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # use on create
  # 二回パスワードを打つ必要あり
  # validates :password, presence: true, confirmation: true, length: {within: 5..30 }

  validates :password, presence: true, length: {within: 5..30}

  has_many :problems

  def update_access_token!
   self.access_token = "#{self.id}:#{Devise.friendly_token}"
   save
  end

  # 自分以外の同じデバイストークンを持つユーザがいたら nil で上書き
  # 一つのデバイストークンは複数のユーザで持たないべき
  def sweep_same_device_tokens(updated_time: Time.zone.now)
    User.where(device_token: self.device_token)
        .where.not(id: self.id)
        .update_all(['device_token = NULL, updated_at = ?', updated_time])
  end

end
