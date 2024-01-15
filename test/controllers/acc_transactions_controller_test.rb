require "test_helper"

class AccTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acc_transaction = acc_transactions(:one)
  end

  test "should get index" do
    get acc_transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_acc_transaction_url
    assert_response :success
  end

  test "should create acc_transaction" do
    assert_difference("AccTransaction.count") do
      post acc_transactions_url, params: { acc_transaction: { account_id: @acc_transaction.account_id, amount: @acc_transaction.amount, date: @acc_transaction.date, description: @acc_transaction.description, source: @acc_transaction.source, user_id: @acc_transaction.user_id } }
    end

    assert_redirected_to acc_transaction_url(AccTransaction.last)
  end

  test "should show acc_transaction" do
    get acc_transaction_url(@acc_transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_acc_transaction_url(@acc_transaction)
    assert_response :success
  end

  test "should update acc_transaction" do
    patch acc_transaction_url(@acc_transaction), params: { acc_transaction: { account_id: @acc_transaction.account_id, amount: @acc_transaction.amount, date: @acc_transaction.date, description: @acc_transaction.description, source: @acc_transaction.source, user_id: @acc_transaction.user_id } }
    assert_redirected_to acc_transaction_url(@acc_transaction)
  end

  test "should destroy acc_transaction" do
    assert_difference("AccTransaction.count", -1) do
      delete acc_transaction_url(@acc_transaction)
    end

    assert_redirected_to acc_transactions_url
  end
end
