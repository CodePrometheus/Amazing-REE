class Admin::ProductImagesController < Admin::BaseController

  before_action :find_product

  def index
    @product_images = @product.product_images
  end

  def create
    params[:images].each do |image|
      @product.product_images << ProductImage.new(image: image) # 图片追加
    end
    redirect_back(fallback_location: admin_product_product_images_path(product_id: @product))
  end

  def destroy
    @product_image = @product.product_images.find(params[:id])
    if @product_image.destroy
      flash[:notice] = "delete success"
    else
      flash[:notice] = "delete failed"
    end
    redirect_back(fallback_location: admin_product_product_images_path(product_id: @product))
  end

  def update
    @product_image = @product.product_images.find(params[:id])
    @product_image.weight = params[:weight]
    if @product_image.save
      flash[:notice] = "update success"
    else
      flash[:notice] = "update failed"
    end
    redirect_back(fallback_location: admin_product_product_images_path(product_id: @product))
  end

  private

  def find_product
    @product = Product.find(params[:product_id])
  end
end
