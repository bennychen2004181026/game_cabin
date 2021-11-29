class ChangeColumnShoppingCarts < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:shopping_carts, :product_id, false)
  end
end
