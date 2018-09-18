require 'test_helper'

class FinanceControllerTest < ActionDispatch::IntegrationTest
  test "should get income" do
    get finance_income_url
    assert_response :success
  end

end
