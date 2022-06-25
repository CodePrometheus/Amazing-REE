class ProductsController < ApplicationController
  def show
    fetch_global_data
    @product = Product.find(params[:id])
    @shopping_cart = ShoppingCart.by_user_uuid(session[:user_uuid]).
      where(:shopping_carts => { :product_id => @product.id })
  end
end