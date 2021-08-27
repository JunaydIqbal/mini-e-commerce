class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, :except => [:index, :show, :search, :add_to_cart, :remove_from_cart, :company_product]
  before_action :initialize_session
  before_action :load_cart

  load_and_authorize_resource
  #require 'thinking_sphinx'
  #require 'thinking_sphinx/capistrano'
  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show

  end

  def my_product
    if current_user.has_role?(:vendor)
      ids = current_user.company.products.pluck(:id) << current_user.company.id
      @products = Product.where(company_id: ids).order('created_at DESC')
    elsif current_user.has_role?(:employee)
      invited_id = current_user.invited_by
      ids = invited_id.company.products.pluck(:id) << invited_id.company.id
      @products = Product.where(company_id: ids).order('created_at DESC')
    else
      flash[:alert] = "You didn't access this page!"
      redirect_to root_path
    end
  end

  def company_product
    curr_company = helpers.fetch_company[1]
    @products = curr_company.products
  end

  # GET /products/new
  def new
    #authorize! :create, @product
    @product = Product.new
    
  end

  # def search
    
  #   @products = Product.search(params[:search])
    
  # end

  def search  
    if params[:search].blank?
      redirect_to(root_path, notice: "Product not found!") and return
    else
      @parameter = params[:search].downcase  
      @products = Product.all.where("lower(name) LIKE :search", search: @parameter)  
      #@products = Product.joins(:company).search(params[:search])
      if @products.count == 0
        redirect_to(search_path, notice: "Product not found!") and return
      end
      
    end  
  end

  # GET /products/1/edit
  def edit
    
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)
    if current_user.has_role?(:vendor)
      @product.company_id = current_user.company.id
    else
      @product.company_id = helpers.fetch_company[1]
    end
    @product.user_id = current_user.id
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    authorize! :destroy, @product
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to products_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to products_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
end
