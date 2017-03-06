require 'spec_helper'

describe StripeWrapper::Charge do
  let(:valid_token) do
    Stripe::Token.create(
      :card => {
      :number => '4242424242424242',
      :exp_month => 2,
      :exp_year => 2020,
      :cvc => "314"
      },
    ).id    
  end

  let(:declined_card_token) do
    Stripe::Token.create(
      :card => {
      :number => '4000000000000002',
      :exp_month => 2,
      :exp_year => 2020,
      :cvc => "314"
      },
    ).id    
  end


  context "with valid credit card" do
    it "charges the card successfully", :vcr do
      response = StripeWrapper::Charge.create(amount: 300, card: valid_token)
      response.should be_successful
    end
  end

  context "with invalid credit card" do
    let(:response) { StripeWrapper::Charge.create(amount: 300, card: declined_card_token) }

    it "does not charge the card successfully", :vcr do
      response.should_not be_successful
    end

    it "contains an error message", :vcr do
      response.error_message.should == "Your card was declined."
    end
  end

  describe StripeWrapper::Customer do
    describe ".create" do
      it "creates a customer with a valid card", :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: alice,
          card: valid_token )
        expect(response).to be_successful
      end

      it "does not create a customer with an invalid card", :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: alice,
          card: declined_card_token )
        expect(response).not_to be_successful
      end

      it "returns the error message for a declined card", :vcr do
        alice = Fabricate(:user)
        response = StripeWrapper::Customer.create(
          user: alice,
          card: declined_card_token )
        expect(response.error_message).to eq("Your card was declined.")
      end
    end
  end
end