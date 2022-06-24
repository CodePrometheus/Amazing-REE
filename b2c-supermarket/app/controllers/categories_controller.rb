class CategoriesController < ApplicationController
  def show
    fetch_category_grouped
    @category = Category.find(params[:id])
    @products = @category.products.on_shelf.page(params[:page] || 1).per_page(params[:per_page] || 12)
                         .order(id: "desc").includes(:main_product_image)
  end
end