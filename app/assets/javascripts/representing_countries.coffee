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

            $(".close-status").on "click", (event) ->
              count = $(".text-status-name").filter((input) ->
                                        $(this).val() != ''
                                      ).length
            $(".nested_fields").last().children().eq(1).val(count)
            $(".nested_fields").last().children().eq(0).text(["Serial No. ", count].join(" "))

    ).observe(
      document.body
      childList   : true
      subtree     : true
    )

turboload = ->
  $('body').on "fields_added.nested_form_fields", (event) ->
    $(".nested_fields").last().append("<i class='fa fa-times text-danger close-status'></i>")

    $(".close-status").on "click", (event) ->
      $(this).parent(".nested_fields").remove()

document.addEventListener 'turbolinks:load', ready
document.addEventListener 'turbolinks:load', turboload
