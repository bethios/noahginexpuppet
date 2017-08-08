class ChargesController < ApplicationController
  def create
    customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: 75_00,
        description: "Watercolor painting",
        currency: 'usd'
    )

    flash[:notice] = "Your payment has been received for a watercolor painting."
    redirect_to complete_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key]}",
        description: "Original watercolor painting",
        amount: 75_00
    }
  end

  def complete

  end
end
