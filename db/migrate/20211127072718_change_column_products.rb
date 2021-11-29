class ChangeColumnProducts < ActiveRecord::Migration[6.0]
  def change
  change_column_null(:products, :category_id, false)
  end
end
