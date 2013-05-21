class AddPhysiologicalPointsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :physiological_points
    end
  end
end