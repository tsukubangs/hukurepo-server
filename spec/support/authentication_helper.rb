module AuthenticationHelper
  def login
    let(:user) { create(:user) }
    let(:token) { user.access_token }
    before do
      sign_in user
    end
  end
end
