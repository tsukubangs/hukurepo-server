module V1
  class UsersController < ApplicationController
    # ここに何も追加しないことで、indexメソッドが認証を必要とするメソッドとなります。
    # 逆に認証を必要としないメソッドを作成したい場合は追加するようにしましょう。
    skip_before_action :authenticate_user_from_token!, only: [:create]

    def index
      render json: User.all, each_serializer: V1::UserSerializer
    end

    # POST
    # Create an user
    def create
      @user = User.new user_params

      if @user.save!
        render json: @user, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
