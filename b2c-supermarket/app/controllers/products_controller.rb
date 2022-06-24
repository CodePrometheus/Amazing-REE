class ProductsController < ApplicationController
  def show
    fetch_global_data
    @product = Product.find(params[:id])
  end
end