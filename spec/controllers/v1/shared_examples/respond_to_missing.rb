RSpec.shared_examples 'respond to missing' do |url|
  before do
    # TODO implements
    # create test resource
    # encode token -> token = JWT.encode({user: User.first.id}, ENV["AUTH_SECRET"], "HS256")
    # add header ->  header "Authorization", "Bearer #{token}"
    # http get access -> get "/v1/users/-1"
  end

  it 'responds with a 404 status' do
    # expect(last_response.status).to eq 404
  end

  it 'responds with a message of Not found' do
    # message = json["errors"].first["detail"]
    # expect(message).to eq("Not found")
  end
end
