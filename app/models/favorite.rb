class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  class << self
  def favorite(user)
    Favorite.where(user_id: user)
  end
end
end
