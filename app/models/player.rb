class Player < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates_presence_of :user
  validates_presence_of :game
end
