class AddDatesToFinals < ActiveRecord::Migration
  def self.up
    Match.find_by({:description => 'Q1'}).
      update_attributes(:match_date => '2011-10-08'.to_date)
    Match.find_by({:description => 'Q2'}).
      update_attributes(:match_date => '2011-10-08'.to_date)

    Match.find_by({:description => 'Q3'}).
      update_attributes(:match_date => '2011-10-09'.to_date)
    Match.find_by({:description => 'Q4'}).
      update_attributes(:match_date => '2011-10-09'.to_date)

    Match.find_by({:description => 'S1'}).
      update_attributes(:match_date => '2011-10-15'.to_date)
    Match.find_by({:description => 'S2'}).
      update_attributes(:match_date => '2011-10-16'.to_date)

    Match.find_by({:description => 'Bronze Final'}).
      update_attributes(:match_date => '2011-10-21'.to_date, :description => 'Bronze')
    Match.find_by({:description => 'Final'}).
      update_attributes(:match_date => '2011-10-23'.to_date)
  end

  def self.down
    Match.find_by({:description => 'Bronze'}).
      update_attributes(:description => 'Bronze Final')
  end
end
