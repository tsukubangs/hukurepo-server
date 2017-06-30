module ModelHelper
  def first_user
    User.exists? ? User.first : create(:user)
  end

  def second_user
    create(:user) unless User.exists?
    User.second ? User.second : create(:user2)
  end
end
