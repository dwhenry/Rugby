class RenameLeagueMemberToPlayer < ActiveRecord::Migration
  def change
    rename_table :league_members, :players
  end
end
