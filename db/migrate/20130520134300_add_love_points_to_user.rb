class AddLovePointsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :love_points
    end
  end
end