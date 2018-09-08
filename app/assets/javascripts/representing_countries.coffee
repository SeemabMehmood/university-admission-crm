$ ->
  ready()

ready = ->
  if $(".nested_fields").length > 1
    count = parseInt($(".nested_fields").last().children().eq(1).val())
  else
    count = 1

  target = document.querySelector(".nested_fields")
  MutationObserver        = window.MutationObserver || window.WebKitMutationObserver
  if MutationObserver
    (
      new MutationObserver (mutations) ->
        mutations.forEach (mutation) ->
          if $(mutation.addedNodes).is(".nested_fields")
            count += 1
            $(".nested_fields").last().children().eq(1).val(count)
            $(".nested_fields").last().children().eq(0).text(["Serial No. ", count].join(" "))

    ).observe(
      document.body
      childList   : true
      subtree     : true
    )

document.addEventListener 'turbolinks:load', ready
