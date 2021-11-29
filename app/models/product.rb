class Product < ApplicationRecord

  # Attach product's uuid when create

  after_initialize :set_uuid, if: :new_record?

  # Validation of category_id attribute
  validates :category_id, presence: { message: 'Should has a category.' }
  # Validation of title attribute
  validates :title, presence: { message: 'Name should be provided.' }
  validates_length_of :title, within: 1..80, too_long: 'pick a shorter name', too_short: 'pick a longer name'
  # Validation of status attribute
  validates :status, inclusion: { in: %w[available not_available],
                                  message: 'Status has to be available or not available.' }
  # Validation of amount attribute
  validates :amount, numericality: { only_integer: true,
                                     message: 'Inventory amount has to an integer.' },
                     if: proc { |product| !product.amount.blank? }
  validates :amount, numericality: { greater_than_or_equal_to: 0,
                                     message: 'Inventory amount has to greater than or equal to 0.' },
                     if: proc { |product| !product.amount.blank? }
  validates :amount, presence: { message: 'Inventory amount should be provided.' }
  # Validation of price attribute
  validates :price, presence: { message: 'Price should be provided.' }
  validates :price, numericality: { message: 'Price should be a number.' },
                    if: proc { |product| !product.price.blank? }
  validates :price, numericality: { greater_than_or_equal_to: 0,
                                    message: 'Price has to greater than or equal to 0.' },
                    if: proc { |product| !product.amount.blank? }
  # less than 99999.99
  validates :price, numericality: { less_than_or_equal_to: BigDecimal(10**5),
                                    message: 'Price has to be less than 100000.' },
                    if: proc { |product| !product.amount.blank? }
  # Decimal regexp expression, precision 7, scale 2
  validates :price, format: { with: /\A\d{1,5}(\.\d{1,2})?\z/ }
  # Validation of attached image
  validates :product_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif'],
                            size: { less_than: 8.megabytes, message: 'is too bid, maximin size is 8mb!' }
  # Validation of description attribute
  validates :description, presence: { message: 'Should have description.' }
  validates :description, length: { maximum: 3000,
                              too_long: '%{count} characters is the maximum allowed' }


  # Status helper module is located at application record to provide two status attributes
  scope :available, -> { where(status: Status::Available) }

  belongs_to :category
  has_one :shopping_cart
  belongs_to :user
  has_one_attached :product_image
  has_one :order


  private

  # Rails 6 method for generate a Version 4 UUIDs.
  def set_uuid
    self.uuid = SecureRandom.base36(24)
  end
end
