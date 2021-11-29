class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  # Two kind of user role

  enum role: [:user,:admin]
  # When user created, attach role and uuid attributes
  # after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_user_uuid, :if => :new_record?
  
  has_one :address , dependent: :destroy
  has_many :shopping_carts
  has_many :orders
  has_many :products
  


  # When new user create, it's normal user account.
  # And it ensures all user records has an unique uuid
  # def set_default_role
  #   self.role ||= :user
  # end
  
  def set_user_uuid
   self.uuid ||= SecureRandom.base36(24)
  end

  # helper for better name displaying

  def username
    email.split('@').first
  end
 
end
