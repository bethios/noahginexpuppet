class ChargesController < ApplicationController
  def create
    size = params[:size]
    puts size
    customer = Stripe::Customer.create(
        email: 'bethios@gmail.com',
        card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
        customer: customer.id,
        amount: 75_00,
        description: "BigMoney",
        currency: 'usd'
    )

    flash[:notice] = "Your payment has been received! "
    redirect_to art_path

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
        key: "#{ Rails.configuration.stripe[:publishable_key]}",
        description: "Original 9x6 watercolor painting",
        amount: 75_00
    }
  end
end
