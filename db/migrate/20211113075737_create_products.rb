class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.references :category,foreign_key: true
      t.string :title, null: false,unique:true
      # May design different status for product item later
      t.string :status, default: 'available', null: false
      t.integer :amount, default: 0, null: false
      # uuid is for future checkout infromation and recipr need.
      t.string :uuid, null: false
      # user_uuid is for identify who is the owner and for authorization to edit the items
      t.string :user_uuid, null: false
      t.decimal :price, precision: 7, scale: 2, null: false
      t.text :description, null: false
      t.timestamps
    end
    # Add indexes for different conditions searching and display
    # If I have enough time to implement...
    add_index :products, [:status, :category_id]
    add_index :products, [:uuid], unique: true 
    add_index :products, [:title]
    add_index :products, [:price]
    add_index :products, [:amount]
    add_index :products, [:status]
  end
end
