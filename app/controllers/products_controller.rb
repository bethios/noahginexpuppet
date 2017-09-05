class ProductsController < ApplicationController
  before_action :require_sign_in, except: [:index]

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
    find_product
  end

  def update
    find_product
    if @product.update_attributes(product_params)
      flash[:notice] = "Saved!"
      redirect_to admin_path
    else
      flash.now[:alert] = @product.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    find_product
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
    find_product
  end

  private

  def product_params
    params.require(:product).permit(:description, :price, :active)
  end

  def find_product
    @product = Product.find(params[:id].to_i)
  end
end
