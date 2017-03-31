FactoryGirl.define do
  factory :rate do
    base 'USD'
    quoted 'EUR'
    price 1.06345
    date '2017-03-30'
  end
end
