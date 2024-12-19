# spec/factories/admin_users.rb
FactoryBot.define do
  factory :admin_user do
    email { "admin@super.com" }
    password { "super" }
    # password_confirmation { "super" }
    # role { "admin" }
  end
end
