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

  if $("#new_user").length > 0 || $(".edit_user").length > 0
    $('#populate_agents').hide()
    $('#populate_branch_officers').hide()

    if $('#user_type').val() == "Counsellor"
      $("#download_csv").show()
    else
      $("#download_csv").hide()

    if $(".field_with_errors").length && $('.country-select').length == 0
      $("#download_csv").show(1000)

    $('#user_type').on 'change', (e) ->
      selected = e.target.options[e.target.selectedIndex].value
      if selected == "Branch Officer"
        $('#populate_agents').show(1000)

        $('#agents').on 'change', (eve) ->
          selected_agent = eve.target.options[eve.target.selectedIndex].value

          $.ajax
            type: "GET"
            url: "/representing_countries/get_agent_representing_countries?agent_id=#{selected_agent}"

      else
        $('#populate_agents').hide()

      if selected == "Counsellor"
        $('#populate_agents').show(1000)
        $('#wizardControl').hide(1000)

        $('#agents').on 'change', (eve) ->
          selected_agent = eve.target.options[eve.target.selectedIndex].value

          $.ajax
            type: "GET"
            url: "/users/#{selected_agent}/agent_branch_officers"

          $('#populate_branch_officers').show(1000)

        $('#branch_officers').on 'change', (even) ->
          selected_branch_officer = even.target.options[even.target.selectedIndex].value

          $.ajax
            type: "GET"
            url: "/users/#{selected_branch_officer}/get_user_data"
      else
        $(".country-select").show(1000);
        $("#download_csv").hide(100);
        $(".address").show(1000);
        $(".logo").show(1000);
        $('#populate_branch_officers').hide(1000)
        $('#wizardControl').show(1000)

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
