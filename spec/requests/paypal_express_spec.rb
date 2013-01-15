require 'spec_helper'

describe "Paypal Express checkout" do
  before do
    country = create(:country, :name => 'United States')
    state   = create(:state, :country => country, :name => 'Alaska')
    zone    = create(:zone, :name => 'North America')
    Spree::ZoneMember.create(:zone => zone, :zoneable => country)
    FactoryGirl.create(:shipping_method, :zone => zone)
    FactoryGirl.create(:payment_method, :environment => 'test')
    @product = FactoryGirl.create(:product, :name => "RoR Mug")

    FactoryGirl.create(:ppx)
  end

  let!(:address) { FactoryGirl.create(:address, :country => Spree::Country.first, :state => Spree::State.first) }

  it "should display paypal link", :js => true do
    visit spree.product_path(@product)
    click_button "Add To Cart"
    click_button "Checkout"
    fill_in 'order[email]', :with => 'spree@example.com'

    str_addr = "bill_address"
    select "United States", :from => "order_#{str_addr}_attributes_country_id"
    ['firstname', 'lastname', 'address1', 'city', 'zipcode', 'phone'].each do |field|
      fill_in "order_#{str_addr}_attributes_#{field}", :with => "#{address.send(field)}"
    end
    select "#{address.state.name}", :from => "order_#{str_addr}_attributes_state_id"
    click_button "Save and Continue"

    #delivery
    click_button "Save and Continue"

    choose "Paypal"
    page.should have_selector('input#ppx')
    click_button "Save and Continue"

    current_path.should match /\A\/orders\/[A-Z][0-9]{9}\/checkout\/paypal_payment\z/
  end
end
