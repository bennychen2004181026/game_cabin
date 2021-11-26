class ProductsController < ApplicationController
   # Devise's helper user authentication method
   before_action :authenticate_user!
   # Make it easy for searching
   before_action :get_categories_and_carts_num

  before_action :product_params, only: [:create, :update]
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
    @product = Product.find(params[:id])
  end

  def new

    @product = Product.new

    @root_categories = Category.roots

  end



  def create

    @product = Product.create(product_params)

    @root_categories = Category.roots
  # authorization method from pundit
  authorize @product
 # Append user's uuid to this product so let this product give full access to this user.
 @product.user_uuid = current_user.uuid 

    if @product.save
      
     
      flash[:notice] = "Successfully created."

      redirect_to root_path

    else
      flash[:alert] = "Sorry, it failed."
      render action: :new

    end
  end

  def edit
    @product = Product.find(params[:id])
    # authorization method from pundit
  authorize @product
    @root_categories = Category.roots

    render action: :new

  end



  def update
    @product = Product.find(params[:id])
    # authorization method from pundit
  authorize @product

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
    @product = Product.find(params[:id])
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
    @products = Product.where("title like :title", title: "%#{params[:w]}%")
      .order("id desc").page(params[:page] || 1).per_page(params[:per_page] || 12)
      .includes(:product_image_attachment)

    unless params[:category_id].blank?
      @products = @products.where(category_id: params[:category_id])
    end

    render file: 'home/index'
  end



  private
    def product_params
      params.require(:product).permit(:category_id,:title,:status,:amount, :uuid, :price, :description,:product_image)
    end
end
