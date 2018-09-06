require "application_system_test_case"

class RepresentingCountriesTest < ApplicationSystemTestCase
  setup do
    @representing_country = representing_countries(:one)
  end

  test "visiting the index" do
    visit representing_countries_url
    assert_selector "h1", text: "Representing Countries"
  end

  test "creating a Representing country" do
    visit representing_countries_url
    click_on "New Representing Country"

    fill_in "Name", with: @representing_country.name
    fill_in "Status", with: @representing_country.status
    click_on "Create Representing country"

    assert_text "Representing country was successfully created"
    click_on "Back"
  end

  test "updating a Representing country" do
    visit representing_countries_url
    click_on "Edit", match: :first

    fill_in "Name", with: @representing_country.name
    fill_in "Status", with: @representing_country.status
    click_on "Update Representing country"

    assert_text "Representing country was successfully updated"
    click_on "Back"
  end

  test "destroying a Representing country" do
    visit representing_countries_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Representing country was successfully destroyed"
  end
end
