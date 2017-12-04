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
  validate :validate_role

  has_many :problems

### VALIDATE ###

  def validate_role
    unless User.is_allow_role?(self.role)
      errors.add(:role, "allow only 'poster' or 'respondent' or 'other'")
    end
  end

### USER MODEL ###
  def self.manager
    @manager ||= User.where(email: ENV['MANAGER_EMAIL']).first
    @manager
  end

### ATTRIBUTES ###

### ACCESS_TOKEN ###

  def update_access_token!
   self.access_token = "#{self.id}:#{Devise.friendly_token}"
   save
  end

### ROLE ###

  def self.is_allow_role?(role)
    allow_roles = ['poster', 'respondent', 'other']
    return allow_roles.include?(role)
  end

  def is_poster?
    return self.role == 'poster'
  end

  def is_respondent?
    return self.role == 'respondent'
  end

  def is_other_role?
    return self.role == 'other'
  end

### DEVICE_TOKEN ###

  # 自分以外の同じデバイストークンを持つユーザがいたら nil で上書き
  # 一つのデバイストークンは複数のユーザで持たないべき
  def sweep_same_device_tokens(updated_time: Time.zone.now)
    User.where(device_token: self.device_token)
        .where.not(id: self.id)
        .update_all(['device_token = NULL, updated_at = ?', updated_time])
  end

  def delete_device_token
    self.update_attribute(:device_token, nil)
  end

### OTHER MODEL ###

  def responded_problems
    ActiveRecord::Base.transaction do
      problem_ids = Response.where(user_id: self.id).select(:problem_id)
      Problem.where(id: problem_ids)
    end
  end

### FOR GRAPHS ###

  def self.gender_ratio
    all_user_count = User.all.count
    genders = User.where.not(gender: nil).group(:gender).count
    gender_ratio = {}
    unless all_user_count.zero? && all_user_count.nil?
      genders.each do |key, value|
        gender_ratio[key] = ((value.to_f/all_user_count.to_f)*100).round(1)
      end
      gender_ratio
    end
  end
end
