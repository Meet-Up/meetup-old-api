class UserController < ApplicationController

  def add_contacts
    contacts_to_add = Hash[params[:contacts].map { |c| [c[:display_name], c] }]
    emails_to_search = contacts_to_add.map { |c| c[:email] }.flatten
    numbers_to_search = contacts_to_add.map { |c| c[:phone_number] }.flatten
    contacts = User.with_email_or_number_in emails_to_search, numbers_to_search
  end
end
