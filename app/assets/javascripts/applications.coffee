$ ->
  ready()

ready = ->
  if $("#new_application").length && $("#error_explanation").length == 0
    $(".application-form").hide()
    $(".institutions").hide()
    $("#passport_no").hide()

    $("#application_representing_country_id").on "change", (event) ->
      selected_country = event.target.options[event.target.selectedIndex].value

      $.ajax
        type: "GET"
        url: "/representing_institutions/get_institutions_from_country?country_id=#{selected_country}"

  $(document).on 'change', '#application_applicant_attributes_dob', ->
    $(this).datepicker 'hide'

  $("#application_applicant_attributes_passport").on "click", (event) ->
    if $(this).is(":checked")
      $('#application_applicant_attributes_passport').attr("value", 1)
      $("#passport_no").show(1000)
      $(".checkbox").hide(1000)
    else
      $('#application_applicant_attributes_passport').attr("value", 0)
      $("#passport_no").hide(1000)
      $(".checkbox").show(1000)

  if $(".edit_application").length
    console.log $("#application_applicant_attributes_passport").val()
    if $("#application_applicant_attributes_passport").val()
      $("#passport_no").show()
      $(".checkbox").hide()
    else
      $("#passport_no").hide()
      $(".checkbox").show()

document.addEventListener 'turbolinks:load', ready
