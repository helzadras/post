require "application_system_test_case"

class ExpensesTest < ApplicationSystemTestCase
  setup do
    @expense = expenses(:one)
  end

  test "visiting the index" do
    visit expenses_url
    assert_selector "h1", text: "Expenses"
  end

  test "should create expense" do
    visit expenses_url
    click_on "New expense"

    fill_in "Account", with: @expense.account_id
    fill_in "Amount due", with: @expense.amount_due
    fill_in "Creditor", with: @expense.creditor
    fill_in "Due date", with: @expense.due_date
    fill_in "Funds", with: @expense.funds
    fill_in "Initial balance", with: @expense.initial_balance
    fill_in "Interest", with: @expense.interest
    fill_in "Purpose", with: @expense.purpose
    fill_in "Terms", with: @expense.terms
    fill_in "User", with: @expense.user_id
    click_on "Create Expense"

    assert_text "Expense was successfully created"
    click_on "Back"
  end

  test "should update Expense" do
    visit expense_url(@expense)
    click_on "Edit this expense", match: :first

    fill_in "Account", with: @expense.account_id
    fill_in "Amount due", with: @expense.amount_due
    fill_in "Creditor", with: @expense.creditor
    fill_in "Due date", with: @expense.due_date
    fill_in "Funds", with: @expense.funds
    fill_in "Initial balance", with: @expense.initial_balance
    fill_in "Interest", with: @expense.interest
    fill_in "Purpose", with: @expense.purpose
    fill_in "Terms", with: @expense.terms
    fill_in "User", with: @expense.user_id
    click_on "Update Expense"

    assert_text "Expense was successfully updated"
    click_on "Back"
  end

  test "should destroy Expense" do
    visit expense_url(@expense)
    click_on "Destroy this expense", match: :first

    assert_text "Expense was successfully destroyed"
  end
end
