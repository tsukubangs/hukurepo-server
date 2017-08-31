module AuthenticationHelper
  def login user_id = 1
    let(:login_user) { User.find(user_id) }
    let(:authorization_header) do
      { 'HTTP_AUTHORIZATION' => login_user.access_token,
        'Content-Type' => 'application/json'
      }
    end
    let(:formdata_header) do
      {
        'HTTP_AUTHORIZATION' => login_user.access_token,
        'Content-Type' => 'multipart/form-data'
      }
    end
    before do
      sign_in login_user
    end
  end
end
