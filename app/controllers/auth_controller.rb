class AuthController < ApplicationController
  def get_token
    @tmp_auth = TmpAuth.find_or_initialize_by_email(params[:email])
    @tmp_auth.save
    UserMailer.delay.confirm_email(@tmp_auth)
    @tmp_auth.delay.destroy
    render json: @tmp_auth
  end

  def confirm_user
  	auth = TmpAuth.find_by_token(params[:token])
  	if auth.nil? || auth.pin != params[:pin]
  		render json: { error: 'pin code error'}
  	else
  		@user = auth.create_user
  		render json: { user: @user.as_json(except: []) }
  	end
  end

  def check
    user = User.find_by_token(params[:token])
    render json: { success: !user.nil? }
  end
end
