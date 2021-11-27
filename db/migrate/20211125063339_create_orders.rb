class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key:true
      t.integer :product_id, null:false
      t.integer :address_id, null:false
      t.integer :amount,null:false
      t.string :order_no,null:false
      t.decimal :total_payment, null:false
      t.timestamps
    end
  end
end
