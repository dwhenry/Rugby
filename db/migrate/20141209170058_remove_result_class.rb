class RemoveResultClass < ActiveRecord::Migration
  def up
    add_column :sides, :score, :integer

    Side.reset_column_information

    Result.all.each do |result|
      home_side, away_side = *result.match.sides
      home_side.update_attributes!(score: result.home_team)
      away_side.update_attributes!(score: result.away_team)
    end

    drop_table :results
  end

  def down
    create_table "results", force: true do |t|
      t.integer  "match_id"
      t.integer  "home_team"
      t.integer  "away_team"
      t.datetime "created_at"
      t.datetime "updated_at"
    end


    Match.all.each do |match|
      home_side, away_side = *match.sides
      match.create_result(
        home_team: home_side.score,
        away_team: away_side.score,
      )
    end

    remove_column :sides, :score, :integer
  end

  class Result < ActiveRecord::Base
    self.table_name = 'results'

    belongs_to :match
  end
end
