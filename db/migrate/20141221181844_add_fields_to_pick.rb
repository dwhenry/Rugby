class AddFieldsToPick < ActiveRecord::Migration
  def change
    add_column :picks, :team_id, :integer
    add_column :picks, :margin, :integer
    add_column :picks, :points, :integer

    add_index :picks, :team_id

    Pick.includes(match: :sides).all.each do |pick|
      home, away = *pick.match.sides
      if pick.pick > 0
        pick.team = home
        pick.margin = points
      elsif pick.pick < 0
        pick.team = away
        pick.margin = points.abs
      end

      pick.points = pick.match.points_for_pick(pick || 0)
    end

    remove_column :picks, :pick
  end
end
