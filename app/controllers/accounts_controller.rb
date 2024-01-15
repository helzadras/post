class AccountsController < ApplicationController
  before_action :set_account, only: %i[show edit update destroy]
  before_action :set_available_accounts, only: %i[index new show]

  def index
    @accounts = Account.all
    # Assuming you have some logic to calculate or retrieve the current balance for each account
    @accounts.each { |account| account.current_balance = account.calculate_available_balance }
    # @accounts.each { |account| account.current_balance = account.calculate_current_balance }
    # @accounts = current_user.accounts.order(:order)
  end

  def show
    @acc_transactions = @account.acc_transactions
    @expenses = @account.expenses
  end

  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to account_url(@account), notice: "Account was successfully created." }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_url(@account), notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    # ActiveRecord::Base.transaction do
      # Destroy associated transactions
      # @account.transactions.destroy_all

      # Destroy the account
      @account.destroy
    # end

    respond_to do |format|
      #format.turbo_stream { render turbo_stream: turbo_stream.remove(@account) }
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
    end
  end

  
  private

  def set_available_accounts
    @available_accounts = Account.all
  end

  def set_account
    @account = Account.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to accounts_url, alert: 'Account not found.' }
    end
  end

  #def set_account
  #  @account = Account.find_by_id(params[:account_id])
  #end

  def account_params
    params.require(:account).permit(:name, :current_balance, :available_balance, :user_id)
  end
end
