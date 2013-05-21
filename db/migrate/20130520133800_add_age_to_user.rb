class AddAgeToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :age
    end
  end
end