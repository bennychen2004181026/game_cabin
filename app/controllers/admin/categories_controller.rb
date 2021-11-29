class Admin::CategoriesController < Admin::BaseController

  before_action :set_root_categories, only: [:new, :create, :edit, :update]
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
  # Get the first class categories object
    if params[:id].blank?
      @categories = Category.roots
    else
    # Get the second class categories object and assign to first class to apply for the same pagination method
      @category = Category.find(params[:id])
      @categories = @category.children
    end
  # Classification with pagination and sort them in descending order
    @categories = @categories.page(params[:page] || 1).per_page(params[:per_page] || 10)
      .order(id: "desc")
  end

  def new
    @category = Category.new
    @root_categories = Category.roots.order(id: 'desc')
  end

  def create
    @category = Category.new(params.require(:category).permit(:title,:weight,:products_quantity,:ancestry))

    if @category.save
      flash[:notice] = "Successfully saved."
      redirect_to admin_categories_path
    else
      # Re initializing a new Category
      render action: :new
    end
  end

  def edit
    render action: :new
  end

  def update
    @category.attributes = params.require(:category).permit(:title,:weight,:ancestry)

    if @category.save
      flash[:notice] = "Successfully updated."
      redirect_to admin_categories_path
    else
      render action: :new
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Successfully Deleted."
      redirect_to admin_categories_path
    else
      flash[:alert] = "Failed to delete!"
      # When it failed to delete, the page will stay in the current page, in case admin user is at the page of more than one
      # Redirect_back redirects the browser to the page that issued the request (the referrer) if possible
      redirect_back
    end
  end

  private
  # Roots method comes from ancestry gem
  def set_root_categories
    @root_categories = Category.roots.order(id: "desc")
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
