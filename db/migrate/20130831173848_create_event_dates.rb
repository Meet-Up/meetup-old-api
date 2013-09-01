class CreateEventDates < ActiveRecord::Migration
  def change
    create_table :event_dates do |t|
      t.integer :event_id
      t.timestamp :start
      t.timestamp :end

      t.timestamps
    end
  end
end
