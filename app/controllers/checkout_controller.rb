class CheckoutController < ApplicationController
  protect_from_forgery only: [:create]
  # Devise's helper user authentication method
  before_action :authenticate_user!
  def create
    # Apply shopping cart model scope method by_user_uuid to help identify which shopping
    # carts' has the same uuid  as current user's uuid and includes corresponding product records
    # for order invoking.
    @shopping_carts = ShoppingCart.by_user_uuid(current_user.uuid).includes(:product)
    # In case the reccords are empty, redirect to shopping cart index path.
    if @shopping_carts.blank? || current_user.address.blank?
      flash[:notice] = 'Please have a postage address and have some shopping cart first!'
      redirect_back fallback_location: new_order_path
      return
    end
    # fetch the address that order will need by user association with address.
    @address = current_user.address
    # Declear a empty order ayy for line_items in strip session
    @orders = []
    @shopping_carts.each do |cart|
      order = {
        name: cart.product.title,
        price: cart.product.price,
        amount: (cart.product.price * 100).to_i,
        currency: 'aud',
        total_price: cart.product.amount * cart.product.price
      }
      @orders << order
    end
    # For strpe payment session
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer: current_user.uuid,
      line_items: @orders,
      customer_email: current_user.email,
      payment_intent_data: {
        metadata: {
          user_id: current_user.id
        }
      },
      success_url: root_url,
      cancel_url: root_url
    )

    @session_id = session.id
    respond_to do |format|
      format.js
    end
  end
end
