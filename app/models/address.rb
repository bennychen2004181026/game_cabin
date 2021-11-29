class Address < ApplicationRecord
     # Validation of user_id attribute
  validates :user_id, presence: true

    # Validation of contact_name attribute
    validates :contact_name, presence: { message: "The buyer shoulld has a name." }
    validates :contact_name, length: { maximum: 80,
        too_long: '%{count} characters is the maximum allowed' }
    # Validation of phone attribute
    validates :phone, presence: { message: "Need a phone number to contact." }
    validates :phone, format: { with: /\(?[0-9]{10}\)?/,
    message: "Phone numbers must be in xxxxxxxxxxx, 0 to 9, 10 digits format." }
    # Validation of street_address attribute
    # I admit I am lazy here, actual address need extra model for single purpose and validation
    validates :street_address, presence: { message: "Address couldn't be empty." }
    # Validation of postcode attribute
    # here is lazy as well, actual au postcode is under 0200 and above 7499
    validates :postcode, presence: { message: "Should provide a postcode." }
    validates :postcode, format: { with: /\(?[0-9]{4}\)?/,
    message: "Phone numbers must be in xxxx, 0 to 9, 4 digits format." }

    # Validation of contact_name attribute
    validates :suburb, presence: { message: "The suburb shoulld be provided." }
    validates :suburb, length: { maximum: 80,
        too_long: '%{count} characters is the maximum allowed' }
    # Validation of contact_name attribute
    # Because I am going to decide a dropdown menu to select state, to I don't need to
    # validate extra format
    validates :state, presence: { message: "The state shoulld be provided." }
    
    

    belongs_to :user
    has_many :order


end
