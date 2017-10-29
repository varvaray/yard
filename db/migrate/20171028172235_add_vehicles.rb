class AddVehicles < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicles do |t|
      t.string :state
      t.string :name

      t.timestamps
    end
  end
end
