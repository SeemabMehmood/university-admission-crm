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

  $(document).on 'change', '#datepicker', ->
    $(this).datepicker 'hide'

  $("#application_applicant_attributes_passport").on "click", (event) ->
    if $(this).is(":checked")
      $('#application_applicant_attributes_passport').attr("value", 1)
      $("#passport_no").show(1000)
      $(".passport-check").hide(1000)
    else
      $('#application_applicant_attributes_passport').attr("value", 0)
      $("#passport_no").hide(1000)
      $(".passport-check").show(1000)

  if $(".edit_application").length
    if $("#application_applicant_attributes_passport").val()
      $("#passport_no").show()
      $(".passport-check").hide()
    else
      $("#passport_no").hide()
      $(".passport-check").show()

  $("#application_accommodation").on "click", (event) ->
    if $(this).is(":checked")
      $('#application_accommodation').attr("value", 1)
    else
      $('#application_accommodation').attr("value", 0)

  $("#application_medical").on "click", (event) ->
    if $(this).is(":checked")
      $('#application_medical').attr("value", 1)
    else
      $('#application_medical').attr("value", 0)

turboload = ->
  $("body").on "click", ".nested_application_applicant_educations a.remove", (e) ->
    $(this).parents(".nested_application_applicant_educations").remove()
    e.preventDefault()

  $("body").on "click", ".nested_application_applicant_languages a.remove", (e) ->
    $(this).parents(".nested_application_applicant_languages").remove()
    e.preventDefault()

  $("body").on "click", ".nested_application_applicant_work_experiences a.remove", (e) ->
    $(this).parents(".nested_application_applicant_work_experiences").remove()
    e.preventDefault()

  $("body").on "click", ".nested_application_applicant_references a.remove", (e) ->
    $(this).parents(".nested_application_applicant_references").remove()
    e.preventDefault()

document.addEventListener 'turbolinks:load', ready
document.addEventListener 'turbolinks:load', turboload
