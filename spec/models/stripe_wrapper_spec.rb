require 'spec_helper'

describe StripeWrapper::Charge do
  let(:token) do
    Stripe::Token.create(
      :card => {
      :number => card_number,
      :exp_month => 2,
      :exp_year => 2020,
      :cvc => "314"
    },
  ).id    
  end
  before { StripeWrapper.set_api_key }

  context "with valid credit card" do
    let(:card_number) { '4242424242424242'}

    it "charges the card successfully", :vcr do
      response = StripeWrapper::Charge.create(amount: 300, card: token)
      response.should be_successful
    end
  end

  context "with invalid credit card" do
    let(:card_number) { '4000000000000002'}
    let(:response) { StripeWrapper::Charge.create(amount: 300, card: token) }

    it "does not charge the card successfully", :vcr do
      response.should_not be_successful
    end

    it "contains an error message", :vcr do
      response.error_message.should == "Your card was declined."
    end
  end
end