(() => {
    $('.add-to-cart-btn').on('click', () => {
        let $this = $(this),
            $amount = $('input[name="amount"]'),
            $prog = $this.find('i');

        if ($amount.length > 0 && parseInt($amount.val()) <= 0) {
            alert("购买数量至少为 1");
            return false;
        }

        $.ajax({
            url: $this.attr('href'),
            method: 'post',
            data: { product_id: $this.data('product-id'), amount: $amount.val() },
            beforeSend: () => {
                if (!$prog.hasClass('fa-spin')) {
                    $prog.addClass('fa-spin');
                }
                $prog.show();
            },
            success: data => {
                if ($('#shopping_cart_modal').length > 0) {
                    $('#shopping_cart_modal').remove();
                }

                $('body').append(data);
                $('#shopping_cart_modal').modal();
            },
            complete: () => {
                $prog.hide();
            }
        })
        return false;
    })
})()
