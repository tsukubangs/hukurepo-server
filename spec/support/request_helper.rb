module Requests
  module JsonHelpers
    def json
      JSON.parse(last_response.body)
    end

    def header_application_json
      let(:header) do
          { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      end
    end
  end
end
