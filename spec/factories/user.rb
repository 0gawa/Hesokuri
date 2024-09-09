FactoryBot.define do
    factory :user do
        name { Faker::Lorem.characters(number: 10) }
        email { Faker::Internet.email }
        sex {1}
        age {25}
        job {2}
        password { 'password' }
        password_confirmation { 'password' }
        # confirmed_at { Time.now }
    end
end