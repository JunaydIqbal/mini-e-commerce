class CheckoutController < ApplicationController

  before_action :load_cart

  def create
    #product = Product.find(params[:id])
    if customer_signed_in?
      @session = Stripe::Checkout::Session.create({
        customer: current_customer.stripe_customer_id,
        payment_method_types: ['card'],
        line_items: @cart.collect {|item| item.to_builder.attributes!},
        mode: 'payment',
        success_url: root_url,
        cancel_url: root_url,
      })
      
      respond_to do |format|
      format.js
      end
    else
      flash[:notice] = "User must be signed in!"
      redirect_to new_customer_session_path
    end
  end

end