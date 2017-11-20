class ApplicationController < ActionController::Base
  include AbstractController::Translation
  # protect_from_forgery with: :exception
  before_action :authenticate_user_from_token!

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  ##
  # User Authentication
  # Authenticates the user with OAuth2 Resource Owner Password Credentials
  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authenticate_error
    end
  end

  protected
  # for sending slack notification
  # TODO 後にpush serviceとして分離する
  def slack_notify(text)
    if Rails.env.production?
      Thread.new do
        Slack.chat_postMessage(text: text, username: 'HukuRepo', channel:"#notification")
      end
    end
  end

  def push_notification(to_user, title, body, data_params = {}, priority = "high")
    return if to_user.device_token.blank?

    fcm_key = get_fcm_key(to_user)
    return if fcm_key.blank?

    Thread.new do
      client = Andpush.build(fcm_key)
      notification_params = {
          title: title,
          body: body,
          icon: "icon",
          color: "#99cc22",
          click_action: "FCM_PLUGIN_ACTIVITY",
          sound:"default"
      }
      response = client.push(to: to_user.device_token, notification: notification_params, data: data_params, priority: priority)
      to_user.delete_device_token if response.json[:failure] == 1
    end
  end

  def translate(comment, to: :japanese)
    return unless Rails.env.production?
    return if ENV['GOOGLE_API_KEY'].blank?

    EasyTranslate.api_key = ENV['GOOGLE_API_KEY']
    EasyTranslate.translate(comment, :to => to)
  end

  private

  def authenticate_with_auth_token auth_token
    unless auth_token.include?(':')
      authenticate_error
      return
    end

    user_id = auth_token.split(':').first
    user = User.where(id: user_id).first

    if user && Devise.secure_compare(user.access_token, auth_token)
      # User can access
      sign_in user, store: false
    else
      authenticate_error
    end
  end

  # Authentication Failure
  # Renders a 401 error
  def authenticate_error
    render json: { error: t('devise.failure.unauthenticated') }, status: 401
  end

  def get_fcm_key(user)
    if user.is_poster?
      return ENV['FCM_HUKUREPO_KEY']
    elsif user.is_respondent?
      return ENV['FCM_REPLY_KEY']
    else
      return ""
    end
  end

end
