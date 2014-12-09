class CreateSides < ActiveRecord::Migration
  def up
    create_table :sides do |t|
      t.references :match, index: true
      t.references :team, index: true
      t.string :side

      t.timestamps
    end

    UpMatch.all.each do |match|
      Side.create!(side: 'home', match: match, team: match.home_team)
      Side.create!(side: 'away', match: match, team: match.away_team)
    end

    remove_column :matches, :away_team_id
    remove_column :matches, :home_team_id
  end

  def down
    add_column :matches, :away_team_id, :integer
    add_column :matches, :home_team_id, :integer
    add_index :matches, :away_team_id
    add_index :matches, :away_team_id

    Match.reset_column_information

    DownMatch.all.each do |match|
      match.home_team_id = match.home_side.team_id
      match.away_team_id = match.away_side.team_id
      match.save!
    end

    drop_table :sides
  end

  class UpMatch < ::Match
    belongs_to :home_team, :class_name => 'Team'
    belongs_to :away_team, :class_name => 'Team'
  end

  class DownMatch < ::Match
    has_one :home_side, -> { where(side: 'home') }, class_name: 'Side'
    has_one :home_side, -> { where(side: 'home') }, class_name: 'Side'

    belongs_to :home_team, :class_name => 'Team'
    belongs_to :away_team, :class_name => 'Team'
  end
end
