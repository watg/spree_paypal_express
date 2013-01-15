FactoryGirl.define do
  factory :ppx_order do |record|
    # associations:
    record.association(:user, :factory => :user)
    record.association(:bill_address, :factory => :address)
    record.association(:shipping_method, :factory => :shipping_method)
    record.ship_address { |ship_address| FactoryGirl.create(:ppx_address, :city => "Chevy Chase", :zipcode => "20815") }
  end

  factory :ppx_order_with_totals, :parent => :order do |f|
    f.after_create { |order| order.line_items << FactoryGirl.create(:line_item, :order => order, :price => 10) }
  end
end
