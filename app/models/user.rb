class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         validates :name, :email, presence: true

         attachment :image
         has_many :contacts
         has_many :movies, through: :favorites
         has_many :favorites, :dependent => :destroy
         has_many :movies, through: :reviews
         has_many :reviews, :dependent => :destroy
         has_many :reviews, through: :likws
         has_many :likes, :dependent => :destroy
         has_many :reviews, through: :comments
         has_many :comments, :dependent => :destroy
         has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
         has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
         has_many :followings, through: :following_relationships
         has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
         has_many :followers, through: :follower_relationships
         def following?(other_user)
           following_relationships.find_by(following_id: other_user.id)
         end
         def follow!(other_user)
           following_relationships.create!(following_id: other_user.id)
         end
         def unfollow!(other_user)
           following_relationships.find_by(following_id: other_user.id).destroy
         end

         def active_for_authentication?
             super && !delete_flag?
         end
end
