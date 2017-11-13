class AddStates < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_states do |t|
      t.string :name, null: false
      t.integer :order, null: false

      t.timestamps
    end
  end
end
