class Cast < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  attr_accessor :author, :timestamp, :likes, :comments
end
