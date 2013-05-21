class AddDateToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :date
    end
  end
end