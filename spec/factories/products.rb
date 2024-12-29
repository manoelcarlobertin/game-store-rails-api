FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { Faker::Lorem.paragraph }
    price { Faker::Commerce.price(range: 100.0..400.0) }
    image { Rack::Test::UploadedFile.new(Rails.root.join("spec/support/images/product_image.png")) }
    status { :available }
    featured { true }
    # abaixo permite alterar um model que está sendo construído antes dele ser criado no banco
    after :build do |product|
      product.productable ||= create(:game)
    end
  end
end
