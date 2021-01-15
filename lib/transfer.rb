#require_relative '../lib/bank_account'
require 'pry'

class Transfer
  attr_reader :amount, :sender, :receiver
  attr_accessor :status

  @@all = []

  def self.all
    @@all
  end

  def initialize(sender, receiver, amount, status = "pending")
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = status
    
  end

 def valid?
  self.sender.valid? && self.receiver.valid?
 end

 def execute_transaction
  if valid? && self.sender.balance >= self.amount && self.status == "pending"
    self.sender.balance -= amount
    self.receiver.balance += amount
    self.status = "complete"
    @@all << self
  else
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
 end

 def reverse_transfer
  @@all[-1].receiver.balance -= amount
  @@all[-1].sender.balance += amount
   self.status = "reversed"
 end
 
end