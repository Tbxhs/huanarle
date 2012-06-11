Spendon.CategoryPopup =
  init : () ->
    self = this
    self.showCateOptions()

  showCateOptions : () ->
    self = this
    $('a.select_cate').click ->
      url = '/users/112313/categories'
      $.get(url, (data) ->
        Spendon.dialog $(data.html)
      , 'json')
      return

$(document).ready ->
  Spendon.CategoryPopup.init()

