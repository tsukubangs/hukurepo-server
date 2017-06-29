module AuthenticationHelper
  def login
    let(:user) { User.exists? ? User.first : create(:user) }
    let(:authorization_header){ {'HTTP_AUTHORIZATION' => user.access_token} }
    let(:formdata_headers) do
      {
        'HTTP_AUTHORIZATION' => user.access_token,
        'Content-Type' => 'multipart/form-data'
      }
    end
    before do
      sign_in user
      @request
    end
  end
end
