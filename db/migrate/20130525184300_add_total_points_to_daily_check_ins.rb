class AddTotalPointsToDailyCheckIns < ActiveRecord::Migration
  def change
    add_column :daily_check_ins, :total_points, :integer
  end
end