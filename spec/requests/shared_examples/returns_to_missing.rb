RSpec.shared_examples 'returns 401' do
  it 'returns authorization error(401)' do
    subject
    expect(last_response.status).to eq(401)
    expect(json['error']).to eq('You need to sign in or sign up before continuing.')
  end
end
