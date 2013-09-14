class PossibleDate < ActiveRecord::Base
	belongs_to :event
	belongs_to :event_date
	belongs_to :user

	attr_accessible :event_date_id, :event_id, :possible_time, :user_id

  def self.save_for_token(token, possible_dates)
    saved_dates = []
    possible_dates.each do |date_info|
      date = PossibleDate.find_or_initialize_by_user_id_and_event_date_id(token.user.id, date_info[:event_date_id])
      next if date_info[:id] != date.id
      date.update_attributes(date_info.merge({
        user_id: token.user.id,
        event_id: token.event.id,
        }))
      saved_dates << date if date.save
    end
    saved_dates
  end
end
