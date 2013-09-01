class CreateEventTokens < ActiveRecord::Migration
  def change
    create_table :event_tokens do |t|
      t.integer :event_id
      t.integer :user_id
      t.string :token

      t.timestamps
    end
  end
end
