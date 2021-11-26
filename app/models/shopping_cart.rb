class ShoppingCart < ApplicationRecord
  validates :user_uuid, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  belongs_to :product



# For searching all the shopping carts that the user has.
scope :by_user_uuid, -> (user_uuid) { where(user_uuid: user_uuid) }

# Thi method is defined for cart controller. '**'represent the argument is a hash.
# Cart attributes has uuid, product id and amount of this item.
def self.create_or_update! options = {}
  # To identify which cart I want to update or creat, I need to fetch the current user uuid and product.
  cond = {
    user_uuid: options[:user_uuid],
    product_id: options[:product_id]
  }
  # 'First' is for searching the newest record of this cart.
  record = where(cond).first
  # if has a match newest record, it means the cart is already create and this product's 'add to cart' 
  # button is already been clicked, then update the attributes
  if record
    # Updating the record amount attribute by using hash merge and update! method to save in database.
    # The exclamation point means when somthing wrong happen, an exception will be arised.
    record.update!(options.merge(amount: record.amount + options[:amount]))
  else
    # If can't find a match one, then create a new one with the attributes hash and save!.
    record = create!(options)
  end
  # Return the new record
 record
end
end
