class Admin::ProductsController < Admin::BaseController

 

  before_action :find_product, only: [:edit, :update, :destroy]
  before_action :product_params, only: [:create, :update]



  def index

    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order("id desc")

  end



  def new

    @product = Product.new

    @root_categories = Category.roots

  end



  def create

    @product = Product.create(product_params)
    @product.user_uuid = current_user.uuid 
    @root_categories = Category.roots

    if @product.save

      flash[:notice] = "Successfully created."

      redirect_to admin_products_path

    else
      flash[:alert] = "Sorry, it failed."
      render action: :new

    end

  end



  def edit

    @root_categories = Category.roots

    render action: :new

  end



  def update

    @product.attributes = product_params

    @root_categories = Category.roots

    if @product.save

      flash[:notice] = "Successfully updated."

      redirect_to admin_products_path

    else
      flash[:alert] = "Failed to update."
      render action: :new

    end

  end



  def destroy

    if @product.destroy

      flash[:notice] = "Successfully deleted."

      redirect_to admin_products_path

    else

      flash[:alert] = "Fail to delete."

      redirect_to :back

    end

  end



  private

  def find_product

    @product = Product.find(params[:id])

  end

  private
    def product_params
      params.require(:product).permit(:category_id,:title,:status,:amount, :uuid, :price, :description,:product_image,:user_uuid)
    end

end