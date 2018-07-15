class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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
end
