module V1
  class DeviceTokensController < ApplicationController
    # PUT v1/users/me/device_token
    # PATCH  v1/users/me/device_token
    def update
      current_user.role = device_token_params[:role] if device_token_params[:role].present?
      current_user.device_token = device_token_params[:device_token]

      ActiveRecord::Base.transaction do
        # TODO パスワード無しでの更新
        current_user.save!(validate: false)
        current_user.sweep_same_device_tokens
      end

      render json: { role: current_user.role, device_token: current_user.device_token }, status: :ok

      rescue => e
      render json: { error: e.message }, status: :unprocessable_entity

    end

    private
      def device_token_params
        params[:role] = 'other' unless User.is_allow_role?(params[:role]) || params[:role].blank?
        params.permit(:role, :device_token)
      end
  end
end
