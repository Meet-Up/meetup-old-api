class EventMailer < ActionMailer::Base
  default from: "info@meetup.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.invite_email.subject
  #
  def invite_email(event, email, url)
	  #@event_name = event.name
	  #@event_description = event.description
	  #@event_creater = event.creater
	  @url = url

    mail to: email, subject: 'event info'
  end

end
