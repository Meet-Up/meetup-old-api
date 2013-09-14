class RenameEventUsersToInvitations < ActiveRecord::Migration
  def up
    rename_table :event_users, :invitations
  end

  def down
    rename_table :invitations, :event_users
  end
end
