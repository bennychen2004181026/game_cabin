class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title, null: false
      # May design different status for product item later
      t.string :status, default: 'Not available'
      t.integer :amount, default: 0, null: false
      t.string :uuid, null: false, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.text :description, null: false
      t.timestamps
    end
    # Add indexes for different conditions searching and display
    add_index :products, [:status, :category_id]
    add_index :products, [:uuid], unique: true 
    add_index :products, [:title]
    add_index :products, [:price]
    add_index :products, [:amount]
    add_index :products, [:status]
  end
end
