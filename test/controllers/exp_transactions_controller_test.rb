require "test_helper"

class ExpTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exp_transaction = exp_transactions(:one)
  end

  test "should get index" do
    get exp_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_exp_transaction_url
    assert_response :success
  end

  test "should create exp_transaction" do
    assert_difference("ExpTransaction.count") do
      post exp_transactions_url, params: { exp_transaction: { amount: @exp_transaction.amount, date: @exp_transaction.date, description: @exp_transaction.description, expense_id: @exp_transaction.expense_id, source: @exp_transaction.source, user_id: @exp_transaction.user_id } }
    end

    assert_redirected_to exp_transaction_url(ExpTransaction.last)
  end

  test "should show exp_transaction" do
    get exp_transaction_url(@exp_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_exp_transaction_url(@exp_transaction)
    assert_response :success
  end

  test "should update exp_transaction" do
    patch exp_transaction_url(@exp_transaction), params: { exp_transaction: { amount: @exp_transaction.amount, date: @exp_transaction.date, description: @exp_transaction.description, expense_id: @exp_transaction.expense_id, source: @exp_transaction.source, user_id: @exp_transaction.user_id } }
    assert_redirected_to exp_transaction_url(@exp_transaction)
  end

  test "should destroy exp_transaction" do
    assert_difference("ExpTransaction.count", -1) do
      delete exp_transaction_url(@exp_transaction)
    end

    assert_redirected_to exp_transactions_url
  end
end
