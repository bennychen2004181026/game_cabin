class OrdersController < ApplicationController
     # Devise's helper user authentication method
     # User need to login to actually start shopping from here!! 
     # So the authentication start from here and the following progress need aythentication as well.
  before_action :authenticate_user!

   def new
    # Fetching the order related data
    get_categories_and_carts_num
    @address = current_user.address
    # Fetch shopping carts from shopping cart model including the product image.
    @shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid)
      .order("id desc").includes(product: :product_image_attachment)
   end
   
   def clear_data
      ShoppingCart.where(user_uuid: current_user.uuid).destroy_all
      Order.where(user_id: current_user.id).destroy_all
  
      head :ok
    end
end