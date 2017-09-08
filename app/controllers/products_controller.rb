class ProductsController < ApplicationController
  before_action :require_sign_in, except: [:index]
  before_action :find_product, except: [:new, :create, :index]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new
    if @product.update_attributes(product_params)
      flash[:notice] = "Saved!"
      redirect_to admin_path
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if params[:product][:delete_image] == '1'
      @product.image = nil
    end

    if @product.update_attributes(product_params)
      flash[:notice] = "Saved!"
      redirect_to admin_path
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = "Deleted!"
      redirect_to admin_path
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      redirect_to admin_path
    end
  end

  def index
    @products = Product.all
  end

  def show
  end

  private

  def product_params
    params.require(:product).permit(:description, :image, :price, :active)
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end
end
