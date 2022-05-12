FactoryBot.define do
  factory :user do
    name { 'A' }
    email { '123456@email.com' }
    password { '4' }
    password_confirmation { '4' }
    admin_flag { 'true' }
  end
  factory :second_user, class: User do
    name { 'B' }
    email { '456@email.com' }
    password { '5' }
    password_confirmation { '5' }
    admin_flag { 'false' }
  end
end
