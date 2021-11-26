module ApplicationHelper
    # This method is invoked from view/shared/_products.html.erb to help arrange a cart display html.
    # It accept a product instant and/or a hash argument which contain a css class to change styling
    # The 'add-to-cart-btn' class will bond to a JavaStript event listener to perform some task.
    def show_add_to_cart product, options = {}
        # If it has no default class inside the link, then add default styling class
        html_class = "btn btn-danger add-to-cart-btn"
    html_class += " #{options[:html_class]}" unless options[:html_class].blank?
    
        # Producing a link to checkout page which has all the carts.
        # <i class='fa fa-spinner'> is an icon from font awsome.
        # 'data-product-id' is for fetching the product id for later usage from JavaStript
        link_to "<i class='fa fa-spinner'></i> Add to Cart".html_safe, shopping_carts_path, class: html_class, 
        'data-product-id': product.id
    end
end