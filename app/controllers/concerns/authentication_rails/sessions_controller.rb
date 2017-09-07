module AuthenticationRails
  class SessionsController < ApplicationController
    def create
      if user = User.find_by(email: params[:email], password: params[:password])
        user.reset_authentication_token!
        render json: {data: {token: sign_authenticate_token(user.autentication_token)}}, status: :created
      end
    end
  end
end