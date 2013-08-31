class AuthController < ApplicationController
  def get_token
    email = params[:email]
    @tmp_auth = TmpAuth.create(email: email)
    @tmp_auth.save
    render json: @tmp_auth
  end

  def confirm_user
  end
end
