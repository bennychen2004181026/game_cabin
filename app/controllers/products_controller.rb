class ProductsController < ApplicationController
   # Devise's helper user authentication method
   # Make sure user is login to have a user_uuid to attach on the item being created or check authority of processing item
   before_action :authenticate_user!
   # Make it easy for searching
   before_action :get_categories_and_carts_num
  # Sanitize params before the item got create or recreate.
  before_action :product_params, only: [:create,:update]
  # Fecching specific prodcut data first for related action need.
  before_action :find_product, only: [:show,:edit, :update, :destroy]
  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order("id desc")
  end


  def show
    # Beacuse products controllers is inherited from application controller 
    # and I invoke can this method from application controller
     # And there is another invoke needed in the categories controller as well,
    # so I choose define the method in application controller rather than using 
    # before_action method.
    get_categories_and_carts_num
 
  end

  def new

    @product = Product.new

    @root_categories = Category.roots

  end



  def create

    @product = Product.create(product_params)
    # Append user's uuid to this product so let this product give full access to this user.
    @product.user_uuid = current_user.uuid 
    @root_categories = Category.roots

    if @product.save
      
     
      flash[:notice] = "Successfully created."

      redirect_to products_path

    else
      flash[:alert] = "Sorry, it failed."
      render action: :new

    end
  end

  def edit

    # authorization method from pundit
  authorize @product
    @root_categories = Category.roots
   # Return to create action andd append user_uuid as well
    render action: :new

  end



  def update

    # authorization method from pundit
  authorize @product
  # Remain the product's owner's uuid, so don't need to re attach user uuid here

    @product.attributes = product_params


    if @product.save

      flash[:notice] = "Successfully updated."

      redirect_to root_path

    else
      flash[:alert] = "Failed to update."
      render action: :new

    end

  end



  def destroy
 
    # authorization method from pundit
  authorize @product
    if @product.destroy

      flash[:notice] = "Successfully deleted."

      redirect_to root_path

    else

      flash[:alert] = "Fail to delete."

      redirect_to :back

    end

  end
  def search
    # searching base on title as the name of product and attaching the image to display
    @products = Product.where("title like :title", title: "%#{params[:w]}%")
      .order("id desc").page(params[:page] || 1).per_page(params[:per_page] || 12)
      .includes(:product_image_attachment)

    unless params[:category_id].blank?
      # searching base on specific category
      @products = @products.where(category_id: params[:category_id])
    end
    # pass the data to home index html
    render file: 'home/index'
  end



  private

  def find_product
    @product = Product.find(params[:id])
  end

    def product_params
      params.require(:product).permit(:category_id,:title,:status,:amount, :uuid, :price, :description,:product_image,:user_uuid)
    end
end
