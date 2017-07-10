module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!, only: [:create]

    # POST /v1/login
    def create
      @user = User.find_for_database_authentication(email: login_params[:email])
      return invalid_email unless @user

      if @user.valid_password?(login_params[:password])
        sign_in :user, @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_password
      end
    end

    # POST /v1/check_access_token
    def check_access_token
      render json: { message: 'This access token is valid' }
    end

    private

    def login_params
      # TODO: requireを入れる手段をあとで追加
      params.permit(:email, :password)
    end

    def invalid_email_or_password
      warden.custom_failure!
      render json: { error: 'Login failed: Email or Password is wrong' }, status: 401
    end

    def invalid_email
      invalid_email_or_password
    end

    def invalid_password
      invalid_email_or_password
    end
  end
end
