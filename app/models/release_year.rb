class ReleaseYear < ApplicationRecord
  has_many :movies
  validates :year, presence: true
end
