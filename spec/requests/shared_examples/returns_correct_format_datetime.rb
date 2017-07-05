RSpec.shared_examples 'returns datetime' do
  it 'returns created_at and updated_at' do
    subject
    expect(json['created_at']).not_to be nil
    expect(json['updated_at']).not_to be nil
  end

  it 'returns correct format datetime' do
    subject
    error_message = ""
    begin
      Time.iso8601(json['created_at'])
      Time.iso8601(json['updated_at'])
    rescue ArgumentError => e
      error_message = e
    end
    expect(error_message).to eq("")
  end
end
