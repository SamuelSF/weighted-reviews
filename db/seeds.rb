# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
Sam = User.create(username: "Sam", email: "Sam@host.com",
    password: "swordfish", password_confirmation: "swordfish")

Bob = User.create(username: "Bob", email: "Bob@host.com",
    password: "swordfish", password_confirmation: "swordfish")

Kristen = User.create(username: "Kristen", email: "Kristen@host.com",
    password: "swordfish", password_confirmation: "swordfish")

dark_souls = Product.create(title: "Dark Souls", description: "Prepare to Cry")

mario_galaxy2 = Product.create(title: "Super Mario Galaxy 2", description: "Best Wii Game",)


