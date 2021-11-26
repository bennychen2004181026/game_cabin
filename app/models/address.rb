class Address < ApplicationRecord
 


    validates :contact_name, presence: { message: "The buyer shoulld has a name." }
    validates :phone, presence: { message: "Need a phone number to contact." }
    validates :street_address, presence: { message: "Address couldn't be empty." }
    validates :postcode, presence: { message: "Should provide a postcode." }
    validates :suburb, presence: { message: "Should provide address suburb." }
    validates :state, presence: { message: "Should provide address state." }
    

    belongs_to :user


end
