class AuthController < ApplicationController
  def get_token
    @tmp_auth = TmpAuth.create(email: params[:email])
    render json: @tmp_auth
  end

  def confirm_user
  	auth = TmpAuth.find_by_token(params[:token])
  	if auth.nil? || auth.pin.to_s != params[:pin]
  		render json: { error: 'pin code error'}
  	else
  		@user = auth.create_user
  		render json: @user
  	end
  end
end
