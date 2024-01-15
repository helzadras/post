class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :set_current_account, only: [:new, :create, :show]
  #before_action :require_login, except: [:index, :show]
  #skip_before_action :set_expense, only: [:fund_all_expenses]

  # GET /expenses or /expenses.json
  def index
    @expenses = Expense.all
  end

  # GET /expenses/1 or /expenses/1.json
  def show
    @user = current_user
    @account = @expense.account
    @exp_transactions = @expense.exp_transactions
    
  end
  
  # GET /expenses/new
  def new
    @user = current_user
    @account = @current_account
    @expense = Expense.new
  end
  
  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
    @account = @expense.account
    @user = current_user
  end

  # POST /expenses
  def create
    @expense = Expense.new(expense_params)
    
    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully created' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity } # Render the 'new' template on validation errors
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @account_id = @expense.account_id
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to accounts_path(@account_id), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  
  # GET /expenses/1/add_funds
  def add_funds
    @expense = Expense.find(params[:id])
    @default_amount = @expense.amount_due.abs.to_f

    if params[:amount].present?
      # User provided a custom amount, update the expense accordingly
      custom_amount = params[:amount].to_f
      @expense.update(funds: @expense.funds + custom_amount)
      redirect_to expense_url(@expense), notice: "Funds added successfully"
    elsif params[:use_default].present?
      # User chose to use the default amount
      @expense.update(funds: @expense.funds + @default_amount)
      redirect_to expense_url(@expense), notice: "Default funds added successfully"
    else
      # Render the view with options to choose or input the amount
      render 'add_funds'
    end
  end

  def pay
    @expense = Expense.find(params[:id])
    @default_amount = @expense.amount_due.abs.to_f

    if params[:amount].present?
      # User provided a custom amount, update the expense accordingly
      custom_amount = params[:amount].to_f
      @expense.update(funds: @expense.funds - custom_amount)  # subtracting funds for payment
      redirect_to expense_url(@expense), notice: "Payment made successfully"
    elsif params[:use_default].present?
      # User chose to use the default amount
      @expense.update(funds: @expense.funds - @default_amount)  # subtracting funds for payment
      redirect_to expense_url(@expense), notice: "Default payment made successfully"
    else
      # Render the view with options to choose or input the amount
      render 'pay'
    end
  end

  # Add a new action for bulk funding
  # app/controllers/expenses_controller.rb
  def fund_all_expenses
    FundAllExpensesJob.perform_later
    redirect_to account_path(@current_account), notice: 'Funding all expenses started. This may take some time.'
  end



  private

  def set_account
    @account = Account.find_by(id: params[:account_id])
  end
  
  def set_current_account
    account_id = params[:account_id] || params.dig(:expense, :account_id)
    @current_account = Account.find_by(id: account_id) || Account.first
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  
  

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:funds, :creditor, :purpose, :initial_balance, :interest, :current_balance, :due_date, :terms, :amount_due, :account_id, :user_id)
  end
  
end
