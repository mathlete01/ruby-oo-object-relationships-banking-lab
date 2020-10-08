lass Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount
  def initialize(sender,receiver,amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end
  def valid?
    @sender.valid? && @receiver.valid?
  end
  def execute_transaction
    #binding.pry
    if valid? && self.status == "pending" && self.sender.balance >= amount
      sender.balance = sender.balance - amount
      receiver.balance = receiver.balance + amount
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
  def reverse_transfer
    if self.status == 'complete'
      receiver.balance = receiver.balance - amount
      sender.balance = sender.balance + amount
      self.status = 'reversed'
    end
  end
end