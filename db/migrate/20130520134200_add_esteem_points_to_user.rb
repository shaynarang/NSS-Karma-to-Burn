class AddEsteemPointsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :esteem_points
    end
  end
end