$ ->
  footable()
  theme_issues()
  ready()

ready = ->
  $('#error_explanation').delay(10000).fadeOut(3000)

  $('#wizardControl a').click (e) ->
    e.preventDefault()
    $('a').removeClass 'active'
    $(this).addClass 'active'

  $('[data-toggle="tooltip"]').tooltip()

  if $('.treeview').hasClass('active')
    $('.treeview-menu').show()
  else
    $('.treeview-menu').hide()

  tree_menu()

turboload = ->
  footable()
  theme_issues()

  $('#side-menu').metisMenu()

theme_issues = ->
  $('.hide-menu').on 'click', (event) ->
    event.preventDefault()
    if $(window).width() < 769
      $('body').toggleClass 'show-sidebar'
    else
      $('body').toggleClass 'hide-sidebar'

footable = ->
  $('.table').footable
    "paging":
      "enabled": true
      "size": 10
      "container": "#paging-ui-container"

tree_menu = ->
  $('.treeview a').on 'click', (e) ->
    if $('.treeview').hasClass('active')
      $('#caret').html('<i class="fa fa-caret-up"></i>')
      $('.treeview-menu').show()
    else
      $('#caret').html('<i class="fa fa-caret-down"></i>')
      $('.treeview-menu').hide()

document.addEventListener 'turbolinks:load', ready
document.addEventListener 'turbolinks:load', turboload
