# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "jwt"

u = User.create(email:"test@test.com",password:"test1234")
u.save!
puts "JWT for user (user #{u.id}): #{JWT.encode({ user_id: u.id }, "secret", "HS256")}"

u=User.create(email:"admin@test.com",password:"test1234", admin: true)
u.save!
puts "JWT for admin (user #{u.id}): #{JWT.encode({ user_id: u.id }, "secret", "HS256")}"