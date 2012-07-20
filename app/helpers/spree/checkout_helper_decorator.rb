Spree::CheckoutHelper.module_eval do

  def checkout_states
    %w(address delivery payment confirm complete)
  end

end
