# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.create([
  { username: "johndoe",
    email: "johndoe@gmail.com",
    password: "password",
    password_confirmation: "password" },
  { username: "janedoe",
    email: "janedoe@gmail.com",
    password: "password",
    password_confirmation: "password" },
  { username: "johndoe2",
    email: "johndoe2@gmail.com",
    password: "password",
    password_confirmation: "password" },
  { username: "janedoe2",
    email: "janedoe2@gmail.com",
    password: "password",
    password_confirmation: "password" },
  { username: "johndoe3",
    email: "johndoe3@gmail.com",
    password: "password",
    password_confirmation: "password" },
  { username: "janedoe3",
    email: "janedoe3@gmail.com",
    password: "password",
    password_confirmation: "password" }
])

users.each do |user|
  puts "Created user: #{user.username}"
end
