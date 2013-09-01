class UserMailer < ActionMailer::Base
  default from: "info@meetup.com"

  def confirm_email(tmp_auth)
    @pin_code = tmp_auth.pin
    mail to: tmp_auth.email, subject: 'Confirm email'
  end
end
