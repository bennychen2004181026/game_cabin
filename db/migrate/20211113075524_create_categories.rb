class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.integer :weight, default: 0
      t.integer :products_quantity, default: 0

      t.timestamps
    end
    add_index :categories, [:title]
  end
end
