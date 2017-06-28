module AuthenticationHelper
  def login
    let(:user) { User.exists? ? User.first : create(:user) }

    let(:authorization_header){ {'HTTP_AUTHORIZATION' => user.access_token} }
    before do
      sign_in user
      @request
    end
  end


end
