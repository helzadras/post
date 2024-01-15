# app/controllers/dashboard_controller.rb

class DashboardController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @accounts = current_user.accounts.order(:order)
      @expenses = current_user.expenses
    end
  end
  
