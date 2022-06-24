class WelcomeController < ApplicationController
  def index
    fetch_global_data
    @products = Product.on_shelf.page(params[:page] || 1).per_page(params[:per_page] || 12)
                       .order(id: "desc").includes(:main_product_image)
  end
end
