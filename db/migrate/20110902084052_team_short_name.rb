class TeamShortName < ActiveRecord::Migration
  def self.up
    add_column :teams, :short_name, :string
    
    names = {"Argentina" => 'ARG',
             "Australia" => 'AUS',
             "Canada" => 'CAN',
             "England" => 'ENG',
             "Fiji" => 'FIJ',
             "France" => 'FRA',
             "Georgia" => 'GEO',
             "Ireland" => 'IRL',
             "Italy" => 'ITA',
             "Japan" => 'JPN',
             "Namibia" => 'NAM',
             "New Zealand" => 'NZL',
             "Romania" => 'ROU',
             "Russia" => 'RUS',
             "Samoa" => 'SAM',
             "Scotland" => 'SCO',
             "South Africa" => 'RSA',
             "Tonga" => 'TGA',
             "USA" => 'USA',
             "Wales" => 'WAL'}
    Team.all.each do |team|
      team.update_attributes(:short_name => names[team.name])
    end
  end

  def self.down
    remove_column :teams, :short_name
  end
end
