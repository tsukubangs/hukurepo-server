module AuthenticationHelper
  def login
    let(:user) { first_user }
    let(:authorization_header) do
      { 'HTTP_AUTHORIZATION' => user.access_token,
        'Content-Type' => 'application/json'
      }
    end
    let(:formdata_header) do
      {
        'HTTP_AUTHORIZATION' => user.access_token,
        'Content-Type' => 'multipart/form-data'
      }
    end
    before do
      sign_in user
    end
  end
end
