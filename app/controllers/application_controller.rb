class ApplicationController < ActionController::Base
  protect_from_forgery
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def auth_user!
    token = params[:token]
    @user = User.find_by_token(token)
    redirect_to root_path if token.nil? || @user.nil?
  end
end
