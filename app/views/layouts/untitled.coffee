  if($('.treeview').hasClass('active')) {
    $('.treeview a').attr('aria-expanded', 'true')
    $('.treeview-menu').attr('aria-expanded', 'true')
    $('.treeview-menu').addClass('collapse in')
    $('.treeview-menu').css('display', 'block')
  }
