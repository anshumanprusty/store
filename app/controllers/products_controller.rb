class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
#binding.pry
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products.all
    end

    respond_to do |format|
       format.html
       format.json
    end

    #respond_to do |format|
    #  format.json { render json:@product, status: :created, location: @product }
    #end

    #render :json => @products

    #respond_to do |format|
     #   format.json { render json:@product, status: :created, location: @product }
    #end    

  end

  # GET /products/1
  # GET /products/1.json
  def show
  end


  def options
    if params[:category_id].present?
      @category = Category.find(params[:category_id])
      @products = @category.products.all

          render :json => @products
          
    end
  end

  def totalprice
    if params[:product_dropdown].present?
      @product = Product.find(params[:product_dropdown])
      @price = @product.price
      @totalprice = @price.to_i*params[:order_quantity].to_i

      render :json => @totalprice

    end
  end

 

  # GET /products/new
  def new
    @product = Product.new

  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
        @products = Product.all
    #binding.pry
    if params[:product][:category].present?
      @category = Category.find params[:product][:category]

      @product = @category.products.new(product_params)
    else
      @product = Product.new(product_params)
    end

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.js {}
        format.json { render json:@product, status: :created, location: @product }
      else
        format.html { render :new }
        render :json => { }, :status => 500
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
        @products = Product.all
    #binding.pry
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.js {}
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      #if params[:product][:category_id].present?
      #  params.require(:product).permit(:name, :price, :category_id)
      #else
      params.require(:product).permit(:name, :price, :category_id)
      #end
    end
end
