class Contact < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 75 }
  belongs_to :user
end
