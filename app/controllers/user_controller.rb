class UserController < ApplicationController

  def add_contacts
    contacts_to_add = Hash[params[:contacts].map { |c| [c[:display_name], c] }]
    emails_to_search = contacts_to_add.values.flatten
    contacts = User.with_email_in emails_to_search
  end
end
