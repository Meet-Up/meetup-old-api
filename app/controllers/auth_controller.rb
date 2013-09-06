class AuthController < ApplicationController
  def get_token
    @tmp_auth = TmpAuth.find_or_create_by_email(params[:email])
    UserMailer.delay.confirm_email(@tmp_auth)
    @tmp_auth.delay.destroy
    render json: @tmp_auth
  end

  def confirm_user
  	auth = TmpAuth.find_by_token(params[:token])
  	if auth.nil? || auth.pin.to_s != params[:pin]
  		render json: { error: 'pin code error'}
  	else
  		@user = auth.create_user
  		render json: { user: @user }
  	end
  end

  def check
    user = User.find_by_token(params[:token])
    render json: { success: !user.nil? }
  end
end
