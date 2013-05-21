class CreateDailyCheckIns < ActiveRecord::Migration
  def change
    create_table :daily_check_ins do |t|
      t.date :date
      t.integer :physiological_points
      t.integer :safety_points
      t.integer :esteem_points
      t.integer :love_points
      t.integer :transcendence_points
      t.integer :spent_points
    end
  end
end
