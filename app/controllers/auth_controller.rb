class AuthController < ApplicationController
  def get_token
    @tmp_auth = TmpAuth.create(email: params[:email])
    render json: @tmp_auth
  end

  def confirm_user
  end
end
