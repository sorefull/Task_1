# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create!(name: :admin,
            email: 'adminuser@example.com',
            password: 'adminadmin',
            password_confirmation: 'adminadmin',
            role: 1)
admin.posts.create!(title: 'admin post', body: 'admins post body')

user1 = User.create!(name: :user1,
            email: 'user1@example.com',
            password: 'useruser',
            password_confirmation: 'useruser',
            role: 0)
user1.posts.create!(title: :title1, body: :body1)
user1.posts.create!(title: :title2, body: :body2)
user1.posts.create!(title: :title3, body: :body4)

user2 = User.create!(name: :user2,
            email: 'user2@example.com',
            password: 'useruser',
            password_confirmation: 'useruser',
            role: 0)
user2.posts.create!(title: :title4, body: :body4)
user2.posts.create!(title: :title5, body: :body5)
user2.posts.create!(title: :title6, body: :body6)

user1.subscribe! admin
user1.subscribe! user2
user2.subscribe! admin
admin.subscribe! user2

user1.posts.find(2).liked_by! admin
user1.posts.find(2).liked_by! user1
user1.posts.find(2).liked_by! user2

user1.posts.find(3).liked_by! admin
user1.posts.find(2).liked_by! user1
user1.posts.find(1).liked_by! user2

user2.posts.find(4).liked_by! admin
user2.posts.find(6).liked_by! user1
user2.posts.find(5).liked_by! user2
