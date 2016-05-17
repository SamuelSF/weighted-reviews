# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
500.times do
    name = Faker::Internet.user_name
    email = Faker::Internet.email(name)
    password = Faker::Internet.password
    password_confirmation = password
    fake_user = User.new
    fake_user.username = name
    fake_user.email = email
    fake_user.password = password
    fake_user.password_confirmation = password_confirmation
    fake_user.save
end