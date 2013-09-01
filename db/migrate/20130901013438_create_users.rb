class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :token

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :token
  end
end
