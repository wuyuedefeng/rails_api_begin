module AuthenticationRails::ModelHelper
  def self.included(base)
    base.class_eval do
      before_create :generate_authentication_token
    end
  end

  def reset_authentication_token!
    generate_authentication_token
    save!
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token 30
    generate_authentication_token if User.exists?(authentication_token: self.authentication_token)
  end
end