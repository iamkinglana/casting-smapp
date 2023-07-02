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

# Create Tweets
users = User.all
users.each do |user|
  3.times do
    user.tweets.create!(
      content: Faker::Lorem.sentence
    )
  end
end

# Create Comments
tweets = Tweet.all
users.each do |user|
  tweets.each do |tweet|
    2.times do
      tweet.comments.create!(
        content: Faker::Lorem.sentence,
        user: user
      )
    end
  end
end

# Create Likes
tweets.each do |tweet|
  users.sample(3).each do |user|
    tweet.likes.create!(
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
