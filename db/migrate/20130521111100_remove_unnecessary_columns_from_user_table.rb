class RemoveUnnecessaryColumnsFromUserTable < ActiveRecord::Migration
  def change
    remove_column :users, :age
    remove_column :users, :date
    remove_column :users, :physiological_points
    remove_column :users, :safety_points
    remove_column :users, :esteem_points
    remove_column :users, :love_points
    remove_column :users, :transcendence_points
  end
end