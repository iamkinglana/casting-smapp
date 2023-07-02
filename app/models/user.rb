class User < ApplicationRecord
  has_many :casts
  has_many :comments
  has_many :follows
end
