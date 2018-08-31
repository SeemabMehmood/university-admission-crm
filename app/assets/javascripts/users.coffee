ready = ->
  $('.table').footable()

$(document).ready ready
document.addEventListener 'turbolinks:load', ready
