class TransactionsController < ApplicationController
  #before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    @transactions = Transaction.all
    @available_accounts = Account.all
    @available_expenses = Expense.all
  end

  # GET /transactions/1 or /transactions/1.json
  def show
    @transactions = Transaction.all # or any other logic to fetch transactions
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    @current_user = current_user
    @available_accounts = Account.all
    @available_expenses = Expense.all
    @context = params[:context] # Set the context here
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @transaction }
    end
  end
  

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.new
    @available_accounts = Account.all
    @available_expenses = Expense.all
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.account = current_account if params[:transaction][:context] == 'account'
    @transaction.expense = current_expense if params[:transaction][:context] == 'expense'
    
    # Set account_id explicitly if an account is associated
    @transaction.account_id = @transaction.account.id if @transaction.account
  
    respond_to do |format|
      if @transaction.save
        # Update the associated account's or expense's balances
        update_association_balances(@transaction)
  
        format.html { redirect_to transaction_url(@transaction), notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  
  

  private

  def update_association_balances(transaction)
    # Assuming that the association (account or expense) has `current_balance` and `available_balance` attributes
    association = transaction.account || transaction.expense
    association.current_balance += transaction.amount
    association.available_balance += transaction.amount
    association.save!
  end
  

  private

  def update_account_balances(account, amount)
    return unless account
  
    # Assuming that the account has `current_balance` and `available_balance` attributes
    account.current_balance ||= 0
    account.available_balance ||= 0
  
    account.current_balance += amount
    account.available_balance += amount
    account.save!
  end
  

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to transaction_url(@transaction), notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction = Transaction.find(params[:id])
    @account_id = @transaction.account_id  # Store the account_id before destroying the record
    @transaction.destroy
  
    respond_to do |format|
      format.html { redirect_to account_path(@account_id), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:date, :source, :description, :amount, :user_id, :account_id, :expense_id)
    end
end
