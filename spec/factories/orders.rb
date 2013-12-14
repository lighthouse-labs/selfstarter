# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    user
    name { Faker::Name.first_name }
    price { (Faker::Number.number(3).to_f)/100 }
    number 1
    factory :authenticated_order do
      zip { Faker::Address.zip_code }
      city { Faker::Address.city }
      state { Faker::Address.state }
      country { Faker::Address.country }
      address_one { Faker::Address.street_address }
      address_two { Faker::Address.secondary_address }
      phone { Faker::PhoneNumber.cell_phone }
      factory :completed_order do
      	token "123456"
      end
    end
  end
end
