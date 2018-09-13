$ ->
  ready()

ready = ->
  if $("#new_application").length
    $(".application-form").hide()
    $(".institutions").hide()

    $("#application_representing_country_id").on "change", (event) ->
      selected_country = event.target.options[event.target.selectedIndex].value

      $.ajax
        type: "GET"
        url: "/representing_institutions/get_institutions_from_country?country_id=#{selected_country}"

  $(document).on 'change', '#application_applicant_dob', ->
    $(this).datepicker 'hide'

document.addEventListener 'turbolinks:load', ready
