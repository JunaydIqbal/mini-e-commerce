# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  include Accessible
  skip_before_action :check_resource, except: [:new, :create]
  
  # GET /resource/sign_up
  def new
    @user = User.new
    @company = Company.new
    #super
  end

  # POST /resource
  def create
    # @user = User.new(configure_sign_up_params)
    # @user.company = Company.create(CREATE_COMPANY_PARAMS)
    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to root_path, notice: 'User was successfully created.' }
    #   else
    #     format.html { render action: 'new' }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
    # @company = Company.new(configure_sign_up_params)
    # @company.user_id = @user
    # super do |created_user|
    #   if created_user.id
    #     company = Company.create! create_company_params
    #     created_user.update! company_id: company.id
    #   end
    # end
    #ss

    if !company_is_exist
      super do |created_user|
        if created_user.id
          
          @company = Company.new(name: params[:user][:company][:name])
          @company.user_id = created_user.id
          @company.save
              
        end
      end
    else
      flash.clear
      flash[:error] = "Company is already exist!"
      redirect_to new_user_registration_path
    end
  end

  def company_is_exist
    check = Company.where(name: params[:user][:company][:name])
    if check == nil
      return false
    end
    true
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :name])
    
  end


  

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
