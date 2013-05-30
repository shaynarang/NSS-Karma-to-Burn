class RenameTotalPointsToEarnedPoints < ActiveRecord::Migration
  def change
    rename_column :daily_check_ins, :total_points, :earned_points
  end
end