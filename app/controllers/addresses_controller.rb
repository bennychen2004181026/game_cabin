class AddressesController < ApplicationController
  # Devise's helper user authentication method
  before_action :authenticate_user!
  protect_from_forgery :except => :create 
  # Helper method to fetch specific address object before the following actions
  before_action :find_address, only: [:index,:edit,:edit, :update, :destroy]
    
  def index
  end

  def new
    # Each instance of the User model will have these methods: .address, .address=, build_address, create_address
    # Because addressed has users' foreign key and use has one relationship with address
    @address = current_user.build_address
  end
 

  def create
    # Use strong params method underneath to sanitize the inputs and create a new address object base on params
    @address = current_user.build_address(strong_address_params)
    if @address.save
      flash[:notice] = "The address has been saved."
      redirect_to new_order_path
    else
      flash[:alert] = "Somthong wrong with the address saving!"
      render action: :new
    end
  end

  def edit
    render action: :new
  end

  def update
    # Use strong params method and update method to renew this object's attributes
    @address.update(strong_address_params)
    if @address.save
      flash[:notice] = "The address has been saved."
      redirect_to new_order_path
    else
      flash[:alert] = "Somthong wrong with the address saving!"
      render action: :new
    end
  end

  def destroy
   if @address.destroy 
    flash[:notice] = "Successfully deleted."
    redirect_to new_order_path
   else
    flash[:alert] = "Fail to delete."

    redirect_back fallback_location: new_order_path
   end
  end

  
  private
 
  def strong_address_params
    params.require(:address).permit(:contact_name, :phone, :street_address,:postcode,:suburb,:state)
  end
 # Beacuse user only has one address and it can be fetched by their assosiation.
  def find_address
    @address = current_user.address

  end
end
