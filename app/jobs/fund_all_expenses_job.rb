# app/jobs/fund_all_expenses_job.rb
class FundAllExpensesJob < ApplicationJob
    queue_as :default
  
    def perform
      Expense.update_all('funds = ABS(amount_due)')
    end
  end
  