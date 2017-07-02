module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

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

    private

    def login_params
      # TODO: requireを入れる手段をあとで追加
      params.permit(:email, :password)
    end

    def invalid_email
      warden.custom_failure!
      render json: { error: t('invalid_email') }, status: 401
    end

    def invalid_password
      warden.custom_failure!
      render json: { error: t('invalid_password') }, status: 401
    end
  end
end
