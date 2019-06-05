class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.integer :kind
      t.string :name
      t.boolean :unique
      t.string :value

      t.timestamps
    end
  end
end
