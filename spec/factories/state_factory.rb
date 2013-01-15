FactoryGirl.define  do
  factory :md_state do |f|
    f.name 'Maryland'
    f.abbr 'MD'
    f.country { |country| country.association(:country) }
  end
end
