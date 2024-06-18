# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#   Character.create(name: "Luke", movie: movies.first)
Admin.create!(
    email: "test@gmail.com",
    password: "111111",
    admin_id: "111111"
)