class AddVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :name, null: false
      t.integer :vehicle_state_id, null: false
      t.timestamps
    end
  end
end
