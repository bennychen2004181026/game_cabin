class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true,null: false
      t.references :address, index: true , foreign_key: true,null: false
      t.integer :amount,null:false
      t.string :order_no,null:false
      t.decimal :total_payment, precision: 10, scale: 2,null:false
      t.timestamps
    end
  end
end
