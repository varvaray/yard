class CreateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :transitions do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.string :on, null: false

      t.timestamps
    end
  end
end
