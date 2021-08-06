class CompanyController < ApplicationController

  before_action :set_company, only: %i[ show edit update destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :index]
  load_and_authorize_resource

  def index
    @company = Company.where(user_id: current_user.id)
  end

  def show
    
  end

  def new

  end

  def create
    @company = Company.new(company_params)
      respond_to do |format|
      if @company.save
        format.html { redirect_to company_index_path, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to company_index_path, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :description, :user_id)
    end

end
