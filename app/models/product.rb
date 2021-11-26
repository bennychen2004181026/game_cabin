class Product < ApplicationRecord

  has_one_attached :product_image 
  belongs_to :category

  before_create :set_uuid
    


    validates :category_id, presence: { message: "Should has a category." }

    validates :title, presence: { message: "Name should be provided." }

    validates :status, inclusion: { in: %w[available not_available], 
      message: "Status has to be available or not available." }

    validates :amount, numericality: { only_integer: true,
      message: "Inventory amount has to an integer." },
      if: proc { |product| !product.amount.blank? }
     validates :amount, numericality: { greater_than_or_equal_to: 0,
      message: "Inventory amount has to greater than or equal to 0." },
          if: proc { |product| !product.amount.blank? }
    validates :amount, presence: { message: "Inventory amount should be provided." }

    validates :price, presence: { message: "Price should be provided." }
    validates :price, numericality: { message: "Price should be a number." },
      if: proc { |product| !product.price.blank? }
        validates :price, numericality: { greater_than_or_equal_to: 0,
          message: "Price has to greater than or equal to 0." },
              if: proc { |product| !product.amount.blank? }

    validates :product_image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg','image/gif'],
        size: { less_than: 8.megabytes , message: 'is too bid, maximin size is 8mb!' }
 

    validates :description, presence: { message: "Should have description." }
    validates :description, length: { maximum: 1000,
      too_long: "%{count} characters is the maximum allowed" }
    # Status helper module is located at application record to provide two status attributes
    scope :available, -> { where(status: Status::Available) }

   

    private
    # Rails 6 method for generate a Version 4 UUIDs.
    def set_uuid
        self.uuid = SecureRandom.base36(24)
    end
end
