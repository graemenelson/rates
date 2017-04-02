FactoryGirl.define do
  factory :rate do
    currency 'USD'
    prices({'EUR' => 1.06345})
    date '2017-03-30'
  end
end
