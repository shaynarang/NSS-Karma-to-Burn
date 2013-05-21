class AddUserIdToDailyCheckIns < ActiveRecord::Migration
  def change
    add_column :daily_check_ins, :user_id, :integer
  end
end