# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create!(email: "whatever@example.com", password: "password1", password_confirmation: "password1")
user_2 = User.create!(email: "hey@example.com", password: "password1", password_confirmation: "password1", api_key: "123")
