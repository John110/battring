# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# @user = User.new
# @user.name = "Sano"
# @user.email = "pippi@gmail.com"
# @user.save

# @user = User.new
# @user.name = "Uramon"
# @user.email = "poppo@gmail.com"
# @user.save

genre = Genre.create(:genre => "RPG")
genre = Genre.create(:genre => "FPS")