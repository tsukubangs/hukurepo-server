module ModelHelper
  def first_user
    User.exists? ? User.first : create(:user)
  end
end
