class CreatePossibleDates < ActiveRecord::Migration
  def change
    create_table :possible_dates do |t|
      t.integer :event_id
      t.integer :user_id
      t.date :event_date_id
      t.string :possible_time

      t.timestamps
    end
  end
end
