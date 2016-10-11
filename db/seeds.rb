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
admin.create_image()
admin.posts.create!(title: 'Title of admin post', body: 'Body of admin post')

user = User.create!(name: :user1, email: 'user1@example.com', password: '11223654', password_confirmation: '11223654')
user.posts.create!(title: 'Title of user post', body: 'Body of user post')
user.create_image()


user2 = User.create!(name: :user2, email: 'user2@example.com', password: '11223654', password_confirmation: '11223654')
user.posts.create!(title: 'Title of user2 post', body: 'Body of user2 post')
user2.create_image()

user.follow admin
user2.follow admin
user2.follow user
