class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :following, foreign_key: "friend_id", class_name: "Friends"
  has_many :followers, foreign_key: "friend_id", class_name: "Friends"
  before_create :set_api_key
  

  validates :username, presence: true       

  def followers(user)
    Friend.where(friend_id: user.id).count
  end


  def generate_api_key
    SecureRandom.base58(24)
  end

  def set_api_key
    self.api_key = generate_api_key
  end 

end
