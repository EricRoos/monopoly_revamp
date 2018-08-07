class Player < ApplicationRecord
  DEFAULT_BALANCE = 1000
  belongs_to :user
  belongs_to :game
  validates_presence_of :user
  validates_presence_of :game
  has_many :money_transactions
  after_create :set_initial_balance

  delegate :email, to: :user

  def balance
    money_transactions.pluck(:amount).sum 
  end

  def can_spend?(amount)
    amount <= balance && amount > 0
  end


  protected

  def set_initial_balance
    MoneyTransaction.create(player: self, amount: DEFAULT_BALANCE)
  end
end
