class AddTranscendencePointsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :transcendence_points
    end
  end
end