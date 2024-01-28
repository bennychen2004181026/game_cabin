class Admin::SessionsController < Admin::BaseController
  before_action :authenticate_user!
  def new
  end
end
