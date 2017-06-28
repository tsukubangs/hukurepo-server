module Requests
  module JsonHelpers
    def json
      JSON.parse(last_response.body)
    end

    def no_params
      {}
    end
  end
end
