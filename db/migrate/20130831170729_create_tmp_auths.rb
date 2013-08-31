class CreateTmpAuths < ActiveRecord::Migration
  def change
    create_table :tmp_auths do |t|
      t.string :email
      t.integer :pin
      t.string :token

      t.timestamps
    end
  end
end
