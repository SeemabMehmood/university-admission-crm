$ ->
  ready()

ready = ->
  target = document.querySelector(".nested_fields")
  MutationObserver        = window.MutationObserver || window.WebKitMutationObserver
  if MutationObserver
    (
      new MutationObserver (mutations) ->
        mutations.forEach (mutation) ->
          if $(mutation.addedNodes).is(".nested_fields")
            $(".nested_fields").last().children().eq(1).val($(".serialno").length)
            $(".nested_fields").last().children().eq(0).text(["Serial No. ", $(".serialno").length].join(" "))

    ).observe(
      document.body
      childList   : true
      subtree     : true
    )

document.addEventListener 'turbolinks:load', ready
