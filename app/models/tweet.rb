class Tweet < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: "user_id"
  validates :content, presence: true
  has_many :likes, dependent: :destroy
  has_many :linking_users, :through => :likes, :source => :user
  has_many :retweets, class_name: 'Tweet', foreign_key: 'retweet_id'
  has_many :tweets
  belongs_to :tweets, optional: true

  paginates_per 50

  scope :tweets_for_me, ->(users_list) { where(
     user_id: users_list.map do |friend|
         friend.friend_id
     end
  ) }
  
end
