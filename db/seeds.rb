# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

# Create Users
5.times do
  User.create!(
    username: Faker::Internet.unique.username,
    email: Faker::Internet.unique.email,
    password: 'password'
  )
end

# Create casts
users = User.all
users.each do |user|
  3.times do
    user.casts.create!(
      content: Faker::Lorem.sentence
    )
  end
end

# Create Comments
casts = Cast.all
users.each do |user|
  casts.each do |cast|
    2.times do
      cast.comments.create!(
        content: Faker::Lorem.sentence,
        user: user
      )
    end
  end
end

# Create Likes
casts.each do |cast|
  users.sample(3).each do |user|
    cast.likes.create!(
      user: user
    )
  end
end

# Create Follows
users.sample(3).each do |follower|
  users.sample(5).each do |followed_user|
    unless follower == followed_user
      Follow.create!(
        follower_id: follower.id,
        followed_user_id: followed_user.id,
        created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
        updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
      )
    end
  end
end
