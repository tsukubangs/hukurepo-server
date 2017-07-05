RSpec.shared_examples 'returns datetime' do
  it 'returns correct format datetime' do
    subject
    error_message = ""
    begin
      Time.iso8601(json['created_at'])
      Time.iso8601(json['updated_at'])
    rescue ArgumentError => e
      error_message = e
    end
    expect(error_message).to be_empty
  end
end
