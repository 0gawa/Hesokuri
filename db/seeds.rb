# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   Character.create(name: "Luke", movie: movies.first)
User.create!(
    email: "test@test.com",
    password: "111111",
    kan_name: "test",
    kana_name: "test",
    sex: 1,
    age: 21,
    job: 2,
    prefecture: 3,
    region: "hello",
    phone_number: "0101111",
    is_smoker: true,
    confirmed_at: Time.now
)

Admin.create!(
    email: "test@test.com",
    password: "111111",
    admin_id: "111111"
)