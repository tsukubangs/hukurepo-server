module V1
  class DeviceTokensController < ApplicationController
    def update
      current_user.device_token = params[:device_token]

      ActiveRecord::Base.transaction do
        # TODO パスワード無しでの更新
        current_user.save(validate: false)
        current_user.sweep_same_device_tokens
      end

      render json: { device_token: current_user.device_token }, status: :ok

      rescue => e
      render json: { error: e.message }, status: :unprocessable_entity

    end
  end
end
end