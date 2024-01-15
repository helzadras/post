class ExpTransaction < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :account, optional: true
  belongs_to :expense

  def funds
    # define the logic to get the funds value, for example:
    self.amount
  end
  
end
