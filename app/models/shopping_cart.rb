class ShoppingCart < ApplicationRecord
  # Validation of user_uuid attribute
  validates :user_uuid, presence: true

  # Validation of product_id attribute
  validates :product_id, presence: true
  # Validation of amount attribute
  validates :amount, numericality: { only_integer: true,
                                     message: 'Order amount has to be an integer.' },
                     if: proc { |product| !product.amount.blank? }
  validates :amount, numericality: { greater_than_or_equal_to: 0,
                                     message: 'Order amount has to greater than or equal to 0.' },
                     if: proc { |product| !product.amount.blank? }
  validates :amount, presence: { message: 'Order amount should be provided.' }

  belongs_to :product

  validate :amount_must_be_less_than_or_equal_to_product_amount
  # For searching all the shopping carts that the user has.
  scope :by_user_uuid, ->(user_uuid) { where(user_uuid: user_uuid) }

  # Thi method is defined for cart controller. '**'represent the argument is a hash.
  # Cart attributes has uuid, product id and amount of this item.
  def self.create_or_update!(options = {})
    cond = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
    }
    record = where(cond).first_or_initialize

    record.amount = record.new_record? ? options[:amount] : record.amount + options[:amount]

    if record.valid?
      record.save!
      record
    else
      Rails.logger.error "ShoppingCart create_or_update! failed: #{record.errors.full_messages.join(', ')}"
      nil
    end
  end

  private

  def amount_must_be_less_than_or_equal_to_product_amount
    return if amount.blank? || product.blank? || product.amount.blank?

    if amount > product.amount
      errors.add(:amount, "can't be greater than the product's available amount")
    end
  end
end
