class AddDatesToFinals < ActiveRecord::Migration
  def self.up
    Match.first(:conditions => {:description => 'Q1'}).
      update_attributes(:match_date => '2011-10-08'.to_date)
    Match.first(:conditions => {:description => 'Q2'}).
      update_attributes(:match_date => '2011-10-08'.to_date)

    Match.first(:conditions => {:description => 'Q3'}).
      update_attributes(:match_date => '2011-10-09'.to_date)
    Match.first(:conditions => {:description => 'Q4'}).
      update_attributes(:match_date => '2011-10-09'.to_date)

    Match.first(:conditions => {:description => 'S1'}).
      update_attributes(:match_date => '2011-10-15'.to_date)
    Match.first(:conditions => {:description => 'S2'}).
      update_attributes(:match_date => '2011-10-16'.to_date)

    Match.first(:conditions => {:description => 'Bronze Final'}).
      update_attributes(:match_date => '2011-10-21'.to_date, :description => 'Bronze')
    Match.first(:conditions => {:description => 'Final'}).
      update_attributes(:match_date => '2011-10-23'.to_date)
  end

  def self.down
    Match.first(:conditions => {:description => 'Bronze'}).
      update_attributes(:description => 'Bronze Final')
  end
end
