# This controller is created only for admin
class Admin::BaseController < ActionController::Base
   # Devise's helper user authentication method
   before_action :authenticate_user!

  #  Specifying Layouts for Admin BaseController
  layout 'admin/layouts/admin'



end
