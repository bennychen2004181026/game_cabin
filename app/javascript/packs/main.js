(function() {

    // For shopping carts
    // This click event will be activated when the '.add-to-cart-btn' class button was click
    $('.add-to-cart-btn').on('click', function() {
        var $this = $(this),
            $amount = $('input[name="amount"]'),
            $prog = $this.find('i');

        if ($amount.length > 0 && parseInt($amount.val()) <= 0) {
            alert("The amount should be greater or equal to 1");
            return false;
        }

        $.ajax({
            // send a post request to 'href''s attached path with the product id which was sent as param and amount data
            url: $this.attr('href'),
            type: "POST",
            data: { product_id: $this.data('product-id'), amount: $amount.val() },
            beforeSend: function() {
                if (!$prog.hasClass('fa-spin')) {
                    $prog.addClass('fa-spin');
                }
                $prog.show();
            },

            success: function(data) {
                if ($('#shopping_cart_modal').length > 0) {
                    $('#shopping_cart_modal').remove();
                }

                $('body').append(data);
                $('#shopping_cart_modal').modal('show');

            },
            complete: function() {
                $prog.hide();
            }
        })
        return false;
    })

})()