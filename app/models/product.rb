class Product < ApplicationRecord
    # Registers a setting Universally Unique IDentifier callback for product item to be called before a record is created
    before_create :set_uuid
    belongs_to :category

    private
    # Rails 6 method for generate a Version 4 UUIDs.
    def set_uuid
        self.uuid = SecureRandom.base36(24)
    end
end
