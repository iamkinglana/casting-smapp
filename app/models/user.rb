class User < ApplicationRecord
  has_many :casts
  has_many :comments
  has_many :follows

  has_many :follower_relationships, foreign_key: :followed_user_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :followed_user_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :followed_user_relationships, source: :followed_user

end
