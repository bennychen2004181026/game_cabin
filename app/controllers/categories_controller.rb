class CategoriesController < ApplicationController

  def show
    # Beacuse categories controllers is inherited from application controller 
    # and I invoke can this method from application controller
    # And there is another invoke needed in the product controller as well,
    # so I choose define the method in application controller rather than using 
    # before_action method.
    get_categories_and_carts_num
    
    @category = Category.find(params[:id])
    # Available scope method is from product model
    @products = @category.products.available.page(params[:page] || 1).per_page(params[:per_page] || 12)
      .order("id desc")
  end

end