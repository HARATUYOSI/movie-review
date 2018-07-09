class DirectorMovie < ApplicationRecord
  belongs_to :director
  belongs_to :movie
end
