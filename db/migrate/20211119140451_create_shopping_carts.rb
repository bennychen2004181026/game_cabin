class CreateShoppingCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :shopping_carts do |t|
      # Because I am going to allow a shopping cart be created before sign in or sign up, which means
      # the cart can belongs to nobody at the beginning, so the user_id can be nil at the beginning.
      t.integer :user_id
      # When any viewer visit the website, an user_uuid is generated in the cookies memory and its purpose is 
      # dealing with the scenario hat when a user didn't login and still can add items to the shopping cart and 
      # help tracking with the shopping cart. In this situation the user_id is nill, but I can assign the user_uuid
      # to the temperary shopping cart if the user want to sign up a new account.
      # If the user is already exists and login, then the existed user_uuid will re-assign to this shopping cart item.
      # In this progress, session is involved to deal with the user_uuid delivery.
      t.string :user_uuid, null: false
      t.references :product, foreign_key:true
      t.integer :amount, null: false
      t.timestamps
    end

    add_index :shopping_carts, [:user_uuid]
  end
end
