class ChangeColumnProducts < ActiveRecord::Migration[6.0]
  def change
  change_column_null(:products, :user_uuid, true)
  end
end
