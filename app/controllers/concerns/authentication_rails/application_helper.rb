module AuthenticationRails::ApplicationHelper
  def self.included(base)
    base.class_eval do
      before_action :authenticate_user
    end
  end

  def authenticate_user
    token, option = ActionController::HttpAuthentication::Token.token_and_options(request)
    head :unauthorized unless valid_authenticate_token?(token)
  end

  def valid_authenticate_token? token
    @current_user = token && User.find_by(authentication_token: token)
  end
end
