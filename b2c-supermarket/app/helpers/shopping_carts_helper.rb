module ShoppingCartsHelper

  def find_already_added_product(product)
    ShoppingCart.by_user_uuid(session[:user_uuid]).
      where(:shopping_carts => { :product_id => product.id }).blank?
  end

  def find_product_amount(product)
    ShoppingCart.by_user_uuid(session[:user_uuid]).
      where(:shopping_carts => { :product_id => product.id }).
      first.try(:amount) || 0
  end

end
