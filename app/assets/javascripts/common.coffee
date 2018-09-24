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
  if $('.treeview').hasClass('active')
    $('li.active.treeview').find('.treeview-menu').show()
  else
    $('li.active.treeview').find('.treeview-menu').hide()

  $('.treeview a').on 'click', (e) ->
    if $(this).parent('.treeview').find('.treeview-menu').length
      $(this).find('#caret').html('<i class="fa fa-caret-up"></i>')
      $(this).parent('.treeview').find('.treeview-menu').show()
    else
      $(this).find('#caret').html('<i class="fa fa-caret-down"></i>')
      $(this).parent('.treeview').find('.treeview-menu').hide()

document.addEventListener 'turbolinks:load', ready
document.addEventListener 'turbolinks:load', turboload
