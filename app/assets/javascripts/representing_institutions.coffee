$ ->
  ready()

ready = ->
  if $("#agents").length > 0
    if $("#error_explanation").length > 0
      $(".rep-countries").show()
    else
      $(".rep-countries").hide()

    $('#representing_institution_agent_id').on 'change', (eve) ->
      selected_agent = eve.target.options[eve.target.selectedIndex].value

      $.ajax
        type: "GET"
        url: "/representing_countries/get_agent_representing_countries?agent_id=#{selected_agent}&institution_form=true"

document.addEventListener 'turbolinks:load', ready
