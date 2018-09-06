$ ->
  footable()

  ready()

ready = ->
  $('#error_explanation').delay(10000).fadeOut(3000)

  $('#wizardControl a').click (e) ->
    e.preventDefault()
    $('a').removeClass 'active'
    $(this).addClass 'active'

  $('[data-toggle="tooltip"]').tooltip()

  $('#populate_agents').hide()
  $('#populate_branch_officers').hide()

  if $("#new_user").length > 0

    $("#download_csv").hide()

    if $(".field_with_errors").length && $('.country-select').length == 0
      $("#download_csv").show()

    $('#user_type').on 'change', (e) ->
      selected = e.target.options[e.target.selectedIndex].value
      if selected == "Branch Officer"
        $('#populate_agents').show()
      else
        $('#populate_agents').hide()

      if selected == "Counsellor"
        $('#populate_agents').show()
        $('#wizardControl').hide()

        $('#agents').on 'change', (eve) ->
          selected_agent = eve.target.options[eve.target.selectedIndex].value

          $.ajax
            type: "GET"
            url: "/users/#{selected_agent}/agent_branch_officers"

          $('#populate_branch_officers').show()

          $('#branch_officers').on 'change', (even) ->
            selected_branch_officer = even.target.options[even.target.selectedIndex].value

            $.ajax
              type: "GET"
              url: "/users/#{selected_branch_officer}/get_user_data"
      else
        $('#populate_agents').hide()
        $('#populate_branch_officers').hide()
        $('#wizardControl').show()

turboload = ->
  footable()

  $('#side-menu').metisMenu()

footable = ->
  $('.table').footable
    "paging":
      "enabled": true
      "size": 10
      "container": "#paging-ui-container"

document.addEventListener 'turbolinks:load', ready
document.addEventListener 'turbolinks:load', turboload
