# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create 10 heads of households
10.times do |n|
  firstname = Faker::Name.first_name
  surname = Faker::Name.last_name
  email = "example-#{n+1}@shoppingapp.org"
  password = "password"
  User.create!(firstname: firstname,
               surname: surname,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               household_id: nil)
end

# And their households:
User.first(10).each do |user|
  @id = Household.create!(name: user.surname + " Household",
                    user_id: user.id,
                    joinable: true).id
  user.update_attributes(household_id: @id)
end

# Make the first 3 housholds unjoinable:
Household.first(3).each do |household|
  household.update_attributes(joinable: false)
end

# Users

# Non-admin users

# Activated

# Belongs to household

# Does not belong to household

# Not activated

# Belongs to household

# Does not belong to household

User.create!(firstname:  "Example",
             surname:     "User",
             email: "example@shoppingapp.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             household_id: 1)

99.times do |n|
  firstname = Faker::Name.first_name
  surname = Faker::Name.last_name
  email = "example-#{n+11}@shoppingapp.org"
  password = "password"
  User.create!(firstname: firstname,
               surname: surname,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
