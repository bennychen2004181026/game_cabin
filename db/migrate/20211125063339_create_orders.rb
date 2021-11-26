class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id, :product_id, :address_id
      t.integer :amount,null:false
      t.string :order_no,null:false
      t.decimal :total_payment, precision: 10, scale: 2,null:false
      t.timestamps
    end
  end
end
