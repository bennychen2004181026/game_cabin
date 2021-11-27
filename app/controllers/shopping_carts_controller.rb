class ShoppingCartsController < ApplicationController
  # This method are apply to renew ande delete action for DRY.
  before_action :find_shopping_cart, only: [:update, :destroy]
  def index
    get_categories_and_carts_num
    # Inovke the scope method define in ShoppingCart model to fetch all the carts that belongs to user has
    @shopping_carts = ShoppingCart.by_user_uuid(session[:user_uuid])
      .order("id desc").includes(product: :product_image_attachment)
  end

  def create
    # Try to fetch the amount attribute of cart, the amount represent how mang specific kind of item in a cart while one cart only contain one kind of item.
    # Use to_i method to turn the attribute to a integer to ensure if the attribute become an integer.
    amount = params[:amount].to_i
    # Because user can choose clicking the homgpage  'add to cart' button or click into the detail page of item to add how many of this item to cart, 
    # so I need a logic to decide the the amount because the amount is setted to default 0 so the homepage click will add one item, and the negative
    # integer will boil down to one and the positive amount input from the detial page would update the amount.
    amount = amount <= 0 ? 1 : amount
    # Fetch the id of this kind of product in this cart
    @product = Product.find(params[:product_id])
    # Asides the product id and amount of this product, I still need to fetch user_uuid from user seesion.
    # Because user can click the homepage 'add to cart' button for one or more time, so we can treat the behaivor differently,
    # so a method defined in cart model will determine what to do base on the cart is newly created or user want to increase
    # the quantity of the product.The argurment is a hash.The exclamation point means this method is going to save and update record in the database.
    @shopping_cart = ShoppingCart.create_or_update!({
      # uuid is fetched from session, because when viewer click the add to cart button before login, a uuid is generated and assign to session.
      user_uuid: session[:user_uuid],
      # product_id is fetched from the url post method
      product_id: params[:product_id],
      # Amount is fetched from above
      amount: amount
    })
    # I don't want to use the layout in views folder and just want to display in a pop up window.
    render layout: false
  end

  def update
    # If the shopping cart exist
    if @shopping_cart
    # Use to_i method to turn the attribute to a integer to ensure the attribute becoming an integer.
      amount = params[:amount].to_i
    # Use ternary Operator to assign the amount
      amount = amount <= 0 ? 1 : amount
    # Renew the amount base on the new amount
      @shopping_cart.update(amount: amount)
    end
    
    redirect_to shopping_carts_path
  end

  def destroy
    # If exists then destroy
    @shopping_cart.destroy if @shopping_cart

    redirect_to shopping_carts_path
  end

  private
  def find_shopping_cart
    # by_user_uuid is shopping cart model scope method to help identify which shopping 
    # carts' attached user_uuid is the same as current user's uuid and then among these carts 
    # using second clause where with the cart's id which coming from url params to identify the newest one.
    @shopping_cart = ShoppingCart.by_user_uuid(session[:user_uuid])
      .where(id: params[:id]).first
  end

end
