class CheckoutController < ApplicationController

  def create
    #product = Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      customer: current_customer.stripe_customer_id,
      payment_method_types: ['card'],
      # line_items: [{
      #   #name: product.name,
      #   #amount: (product.price * 100).to_i,
      #   #currency: "usd",
      #   price: product.stripe_price_id,
      #   quantity: 1
      # }],
      line_items: @cart.collect {|item| item.to_builder.attributes},
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })
    
    respond_to do |format|
    format.js
    end
  end

end