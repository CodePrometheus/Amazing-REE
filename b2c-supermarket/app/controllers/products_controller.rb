class ProductsController < ApplicationController
  def show
    fetch_category_grouped
    @product = Product.find(params[:id])
  end
end