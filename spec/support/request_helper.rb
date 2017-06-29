module Requests
  module JsonHelpers
    def json
      JSON.parse(last_response.body)
    end

    def no_params
      {}
    end

    def authenticate_error_message
      'You need to sign in or sign up before continuing.'
    end
  end
end
