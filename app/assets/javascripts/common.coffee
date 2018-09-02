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
