class CheckoutController < ApplicationController

  before_action :load_cart

  def create
    #product = Product.find(params[:id])
    
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
  end

end