class ApplicationController < ActionController::Base
    include Pundit
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    # This before action method is to ensure every viewer no mater sign in or not to has a user_uuid for using the
    # adding product to shopping cart feature.
    before_action :set_user_uuid_in_cookies
    # If the current user is not authorized, then invoke the method defined in private method  and display alert message.
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    # Because the categories controller and home controller are inherited from there
    # and I need to get the whole categories data in categories controller and home controller,
    # so it's a convenient way to define a method here to reduce the repeat work.
    # Protected is a method tha let the inherited controllers to invoke the methods inside.
    protected

    def get_categories_and_carts_num
      @categories = Category.grouped_data
      @shopping_cart_count = ShoppingCart.by_user_uuid(session[:user_uuid]).count
    end


    def set_user_uuid_in_cookies
      # Try to fetch user_uuid from cookies and assign it to a variable uuid.
      uuid = cookies[:user_uuid]
      # The user_uuid might be nil if the user haven't logged in.
      # Run a loop here untill uuid is not nil.
      unless uuid
        # Devise helper for verifing if a user is signed in
        if user_signed_in?
        # If it's log in and using devise helper current_user to get the uuid and assign it to cookies uuid variable.
        uuid = current_user.uuid
        else
        # If not log in then generate a unique string by rails helper SecureRandom.base36(24) and assign it to uuid.
        uuid = SecureRandom.base36(24)
        end
      end
     # Invoke a reusable method below
      update_session_uuid uuid
    end
    # Sets a simple session cookie.
    # This cookie will be deleted when the user's browser is closed.
    def update_session_uuid  uuid
    # A uuid in cookies can last long enough before leaving the page or log out for security reson.
    # The uuid stored in the session will be used when new user sign up
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
    end

    # Private methods can only be used within the class definition.The only way to have external access to a private 
    # method is to call it within a public method. 
    private
    # Pundit custom error messages
    def user_not_authorized
      flash[:alert] = "Sorry, Access denied. You are not the owner of the item or you are not admin!"
      redirect_to (request.referrer || root_path)
    end
end
