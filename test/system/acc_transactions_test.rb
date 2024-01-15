require "application_system_test_case"

class AccTransactionsTest < ApplicationSystemTestCase
  setup do
    @acc_transaction = acc_transactions(:one)
  end

  test "visiting the index" do
    visit acc_transactions_url
    assert_selector "h1", text: "Acc transactions"
  end

  test "should create acc transaction" do
    visit acc_transactions_url
    click_on "New acc transaction"

    fill_in "Account", with: @acc_transaction.account_id
    fill_in "Amount", with: @acc_transaction.amount
    fill_in "Date", with: @acc_transaction.date
    fill_in "Description", with: @acc_transaction.description
    fill_in "Source", with: @acc_transaction.source
    fill_in "User", with: @acc_transaction.user_id
    click_on "Create Acc transaction"

    assert_text "Acc transaction was successfully created"
    click_on "Back"
  end

  test "should update Acc transaction" do
    visit acc_transaction_url(@acc_transaction)
    click_on "Edit this acc transaction", match: :first

    fill_in "Account", with: @acc_transaction.account_id
    fill_in "Amount", with: @acc_transaction.amount
    fill_in "Date", with: @acc_transaction.date
    fill_in "Description", with: @acc_transaction.description
    fill_in "Source", with: @acc_transaction.source
    fill_in "User", with: @acc_transaction.user_id
    click_on "Update Acc transaction"

    assert_text "Acc transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Acc transaction" do
    visit acc_transaction_url(@acc_transaction)
    click_on "Destroy this acc transaction", match: :first

    assert_text "Acc transaction was successfully destroyed"
  end
end
