module AuthenticationRails::ApplicationHelper
  def self.included(base)
    base.class_eval do
      before_action :authenticate_user
    end
  end

  protected
  def sign_authenticate_token token
    "#{token}#{md5_sign_string(token)}"
  end

  private
  def authenticate_user
    token, option = ActionController::HttpAuthentication::Token.token_and_options(request)
    head :unauthorized unless valid_authenticate_token?(token)
  end

  def valid_authenticate_token? token
    if (split_token = token&.split('.')) && split_token.length == 2 && ActiveSupport::SecurityUtils.secure_compare(sign_authenticate_token(split_token[0]), token)
      @current_user = split_token[0] && User.find_by(authentication_token: split_token[0])
    end
  end

  def md5_sign_string string, secret_key = nil
    string = "#{string}#{secret_key || Rails.application.secrets.secret_key_base}"
    Digest::MD5.hexdigest(string)
  end
end
