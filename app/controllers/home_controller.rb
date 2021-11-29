class HomeController < ApplicationController
  # get '/'
  # get '/home'
  # get '/index'
  def index
    get_categories_and_carts_num
    @products = Product.available.page(params[:page] || 1).per_page(params[:per_page] || 12).order("id desc")
    @users = User.all
  end
end
