class ChangeEventDate < ActiveRecord::Migration
  def up
     change_column  :event_dates, :start, :datetime
	 change_column  :event_dates, :end, :datetime
  end

  def down
     change_column  :event_dates, :start, :timestamp
	 change_column  :event_dates, :end, :timestamp
  end
end
