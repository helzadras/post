class AccTransactionsController < ApplicationController
  before_action :set_acc_transaction, only: %i[ show edit update destroy ]
  before_action :set_current_account, only: [:new, :create, :show]

  # GET /acc_transactions or /acc_transactions.json
  def index
    @acc_transactions = AccTransaction.all
  end

  # GET /acc_transactions/1 or /acc_transactions/1.json
  def show
    @user = current_user
    @account = @acc_transaction.account
  end

  # GET /acc_transactions/new
  def new
    @user = current_user
    @account = @current_account
    @acc_transaction = AccTransaction.new
  end

  # GET /acc_transactions/1/edit
  def edit
    @acc_transaction = AccTransaction.find(params[:id])
    @account = @acc_transaction.account
    @user = current_user # or however you set the user in your application
    # Other code for editing the transaction
  end
  
  
  

  # POST /acc_transactions or /acc_transactions.json
  def create
    @acc_transaction = AccTransaction.new(acc_transaction_params)
    @account = @acc_transaction.account

    respond_to do |format|
      if @acc_transaction.save
        update_current_balance(@account, @acc_transaction.amount)
        format.html { redirect_to account_path(@account), notice: 'Acc transaction was successfully created.' }
        format.json { render :show, status: :created, location: @acc_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @acc_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acc_transactions/1 or /acc_transactions/1.json
  def update
    @account = @acc_transaction.account
    respond_to do |format|
      if @acc_transaction.update(acc_transaction_params)
        # First, undo the previous amount
        update_current_balance(@account, -@acc_transaction.amount_before_last_save)
        # Then, apply the new amount
        update_current_balance(@account, @acc_transaction.amount)
        format.html { redirect_to account_path(@account), notice: 'Acc transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @acc_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @acc_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acc_transactions/1 or /acc_transactions/1.json
  def destroy
    @acc_transaction = AccTransaction.find(params[:id])
    @account_id = @acc_transaction.account_id  # Store the account_id before destroying the record
    @account = Account.find(@account_id)  # Fetch the account
    @acc_transaction.destroy
    update_current_balance(@account, -@acc_transaction.amount)
  
    respond_to do |format|
      format.html { redirect_to account_path(@account_id), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:account_id])
    end
    
    def set_current_account
      account_id = params[:account_id] || params.dig(:acc_transaction, :account_id)
      @current_account = Account.find_by(id: account_id) || Account.first
    end

    def set_acc_transaction
      # Check if params[:id] is present before attempting to find an AccTransaction
      if params[:id].present?
        @acc_transaction = AccTransaction.find(params[:id])
      else
        @acc_transaction = AccTransaction.new
      end
    end
    
    def update_current_balance(account, amount)
      # Subtract the amount from the current balance
      account.update(current_balance: account.current_balance + amount)
    end

    # Only allow a list of trusted parameters through.
    def acc_transaction_params
      params.require(:acc_transaction).permit(:date, :source, :description, :amount, :user_id, :account_id)
    end
end
