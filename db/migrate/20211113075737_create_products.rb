class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      # May design different status for product item later
      t.string :status, default: 'Not available'
      t.integer :amount, default: 0
      t.string :uuid
      t.decimal :price, precision: 10, scale: 2
      t.text :description
      t.timestamps
    end
    # Add indexes for different conditions searching and display
    add_index :products, [:status, :category_id]
    add_index :products, [:uuid], unique: true 
    add_index :products, [:title]
  end
end
