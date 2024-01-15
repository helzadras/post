require "application_system_test_case"

class ExpTransactionsTest < ApplicationSystemTestCase
  setup do
    @exp_transaction = exp_transactions(:one)
  end

  test "visiting the index" do
    visit exp_transactions_url
    assert_selector "h1", text: "Exp transactions"
  end

  test "should create exp transaction" do
    visit exp_transactions_url
    click_on "New exp transaction"

    fill_in "Amount", with: @exp_transaction.amount
    fill_in "Date", with: @exp_transaction.date
    fill_in "Description", with: @exp_transaction.description
    fill_in "Expense", with: @exp_transaction.expense_id
    fill_in "Source", with: @exp_transaction.source
    fill_in "User", with: @exp_transaction.user_id
    click_on "Create Exp transaction"

    assert_text "Exp transaction was successfully created"
    click_on "Back"
  end

  test "should update Exp transaction" do
    visit exp_transaction_url(@exp_transaction)
    click_on "Edit this exp transaction", match: :first

    fill_in "Amount", with: @exp_transaction.amount
    fill_in "Date", with: @exp_transaction.date
    fill_in "Description", with: @exp_transaction.description
    fill_in "Expense", with: @exp_transaction.expense_id
    fill_in "Source", with: @exp_transaction.source
    fill_in "User", with: @exp_transaction.user_id
    click_on "Update Exp transaction"

    assert_text "Exp transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Exp transaction" do
    visit exp_transaction_url(@exp_transaction)
    click_on "Destroy this exp transaction", match: :first

    assert_text "Exp transaction was successfully destroyed"
  end
end
