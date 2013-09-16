class ChangePinToString < ActiveRecord::Migration
  def up
    change_column :tmp_auths, :pin, :string
  end

  def down
    change_column :tmp_auths, :pin, :integer
  end
end
