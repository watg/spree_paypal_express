FactoryGirl.define do
  factory :ppx_order do |record|
    user
    bill_address
    ship_address
    record.association(:shipping_method, :factory => :shipping_method)
  end

  factory :ppx_order_with_totals, :parent => :order do |f|
    f.after(:create) { |order| FactoryGirl.create(:line_item, :order => order, :price => 10) and order.line_items.reload }
  end
end
