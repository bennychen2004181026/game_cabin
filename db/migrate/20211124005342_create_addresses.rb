class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.references :user, index: { unique: true }, foreign_key: true,null: false
      t.string :contact_name,null: false
      t.string :phone,null: false
      t.string :street_address,null: false
      t.string :suburb,null: false
      t.string :state,null: false
      t.integer :postcode,null: false
      t.timestamps
    end

  end
end
