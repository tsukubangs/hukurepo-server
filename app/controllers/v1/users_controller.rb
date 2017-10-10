module V1
  class UsersController < ApplicationController
    include Orderable
    # ここに何も追加しないことで、indexメソッドが認証を必要とするメソッドとなる
    # 逆に認証を必要としないメソッドを作成したい場合はskipを追加するように！
    skip_before_action :authenticate_user_from_token!, only: [:create]
    before_action :set_user, only: [:show]

    wrap_parameters :user, include: [:email, :password, :gender, :age, :country_of_residence, :image]

    def index
      render json: User.order(ordering_params(params)).all, each_serializer: V1::UserSerializer
    end

    # GET /v1/users/1
    def show
      render json: @user, serializer: V1::UserSerializer, root: nil
    end

    # GET /v1/users/me
    def me
      render json: current_user, serializer: V1::UserSerializer, root: nil
    end

    # POST /v1/users
    def create
      @user = User.new user_params

      if @user.save!
        render json: @user, status: :created, serializer: V1::SessionSerializer, root: nil
      else
        render json: { error: t('user_create_error') }, status: :unprocessable_entity
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      # TODO: requireを入れる手段をあとで追加
      params.require(:user).permit(:email, :password, :gender, :age, :country_of_residence, :role)
    end
  end
end
