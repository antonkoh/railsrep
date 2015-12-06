class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable

  has_one :user_profile
  has_many :posts #by this author
  has_many :comments

  has_many :comment_subscriptions
  has_many :subscribed_posts, through: :comment_subscriptions, source: :post



end
