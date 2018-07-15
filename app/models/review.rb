class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :users, through: :likes
  has_many :likes, :dependent => :destroy
  has_many :users, through: :comments
  has_many :comments, :dependent => :destroy
  def favorited_by?(user)
   likes.where(user_id: user.id).exists?
  end
end
