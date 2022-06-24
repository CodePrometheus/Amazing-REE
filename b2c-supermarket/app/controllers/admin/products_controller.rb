class Admin::ProductsController < Admin::BaseController

  before_action :find_product, only: [:edit, :update, :destroy]
  before_action :find_category, only: [:new, :create, :edit, :update]

  def index
    @products = Product.page(params[:page] || 1).
      per_page(params[:per_page] || 10).
      order("id desc")
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params.require(:product).permit!)

    if @product.save
      flash[:notice] = "save success"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def edit
    render action: :new
  end

  def update
    @product.attributes = params.require(:product).permit!
    if @product.save
      flash[:notice] = "update success"
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "delete success"
      redirect_to admin_products_path
    else
      flash[:notice] = "delete failed"
      redirect_to :back
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def find_category
    @root_categories = Category.roots
  end
end
