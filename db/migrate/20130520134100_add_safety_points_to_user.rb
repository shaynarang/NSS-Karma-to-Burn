class AddSafetyPointsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :safety_points
    end
  end
end