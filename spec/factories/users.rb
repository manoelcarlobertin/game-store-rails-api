FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
    profile { :admin } # ou :client
  end
end
