class MoneyTransaction < ApplicationRecord
  belongs_to :player
  validates_presence_of :amount
end
