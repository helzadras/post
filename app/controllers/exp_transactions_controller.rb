class ExpTransactionsController < ApplicationController
  before_action :set_exp_transaction, only: %i[ show edit update destroy ]
  before_action :set_current_expense, only: [:new, :create, :show]

  # GET /exp_transactions or /exp_transactions.json
  def index
    @exp_transactions = ExpTransaction.all
  end

  # GET /exp_transactions/1 or /exp_transactions/1.json
  def show
    #@expense = Expense.find(params[:id])
    #@expense = @exp_transactions.expense
    @exp_transaction = ExpTransaction.find(params[:id])

  end

  # GET /exp_transactions/new
  def new
    @expense = @current_expense
    @exp_transaction = ExpTransaction.new
  end

  # GET /exp_transactions/1/edit
  def edit
    @exp_transaction = ExpTransaction.find(params[:id])
    @expense = @exp_transaction.expense

    # Other code for editing the transaction
  end
  
  
  

  # POST /exp_transactions or /exp_transactions.json
  def create
    @exp_transaction = ExpTransaction.new(exp_transaction_params)
    @expense = @exp_transaction.expense
  
    respond_to do |format|
      if @exp_transaction.save
        update_fund(@expense, @exp_transaction.amount)
        @exp_transactions = @expense.exp_transactions.reload  # Reload the transactions
        format.html { redirect_to expense_path(@expense), notice: 'Exp transaction was successfully created.' }
        format.json { render :show, status: :created, location: @exp_transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @exp_transaction.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /exp_transactions/1 or /exp_transactions/1.json
  def update
    @expense = @exp_transaction.expense
    respond_to do |format|
      if @exp_transaction.update(exp_transaction_params)
        # First, undo the previous amount
        update_fund(@expense, -@exp_transaction.amount_before_last_save)
        # Then, apply the new amount
        update_fund(@expense, @exp_transaction.amount)
        format.html { redirect_to expense_path(@expense), notice: 'Exp transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @exp_transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exp_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exp_transactions/1 or /exp_transactions/1.json
  def destroy
    @exp_transaction = ExpTransaction.find(params[:id])
    @expense_id = @exp_transaction.expense_id  # Store the expense_id before destroying the record
    @expense = Expense.find(@expense_id)  # Fetch the expense
    @exp_transaction.destroy
    update_fund(@expense, -@exp_transaction.amount)
  
    respond_to do |format|
      format.html { redirect_to expense_path(@expense_id), notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private


    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:expense_id])
    end
    
    def set_current_expense
      expense_id = params[:expense_id] || params.dig(:exp_transaction, :expense_id)
      @current_expense = Expense.find_by(id: expense_id) 
    end

    #def set_exp_transaction
      # Check if params[:id] is present before attempting to find an ExpTransaction
    #  if params[:id].present?
    #    @exp_transaction = ExpTransaction.find(params[:id])
    #    @expense = @exp_transaction.expense
    #  else
    #    @exp_transaction = ExpTransaction.new
    #    @expense = Expense.find_by(id: params[:exp_transaction][:expense_id])
    #  end
    #end
    
    def set_exp_transaction
      if params[:id].present?
        @exp_transaction = ExpTransaction.find(params[:id])
        @expense = @exp_transaction.expense
      else
        @exp_transaction = ExpTransaction.new(exp_transaction_params)
        if @exp_transaction.save
          @expense = @exp_transaction.expense
        else
          @exp_transaction = ExpTransaction.new
          @expense = Expense.find_by(id: params[:exp_transaction][:expense_id])
        end
      end
    end
    
    
    def update_fund(expense, amount)
      # Subtract the amount from the current balance
      expense.update(funds: expense.funds + amount)
    end

    # Only allow a list of trusted parameters through.
    def exp_transaction_params
      params.require(:exp_transaction).permit(:date, :source, :description, :amount, :expense_id)
    end
end
