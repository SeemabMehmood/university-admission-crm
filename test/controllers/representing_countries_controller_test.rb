require 'test_helper'

class RepresentingCountriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @representing_country = representing_countries(:one)
  end

  test "should get index" do
    get representing_countries_url
    assert_response :success
  end

  test "should get new" do
    get new_representing_country_url
    assert_response :success
  end

  test "should create representing_country" do
    assert_difference('RepresentingCountry.count') do
      post representing_countries_url, params: { representing_country: { name: @representing_country.name, status: @representing_country.status } }
    end

    assert_redirected_to representing_country_url(RepresentingCountry.last)
  end

  test "should show representing_country" do
    get representing_country_url(@representing_country)
    assert_response :success
  end

  test "should get edit" do
    get edit_representing_country_url(@representing_country)
    assert_response :success
  end

  test "should update representing_country" do
    patch representing_country_url(@representing_country), params: { representing_country: { name: @representing_country.name, status: @representing_country.status } }
    assert_redirected_to representing_country_url(@representing_country)
  end

  test "should destroy representing_country" do
    assert_difference('RepresentingCountry.count', -1) do
      delete representing_country_url(@representing_country)
    end

    assert_redirected_to representing_countries_url
  end
end
