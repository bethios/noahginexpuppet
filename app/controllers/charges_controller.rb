class ChargesController < ApplicationController
  def create
    @price = params[:price]

    customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: @price,
        description: "Noah Ginex Art Work",
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
        description: "Noah Ginex Art Work",
        amount: @price
    }
  end

  def complete

  end
end
