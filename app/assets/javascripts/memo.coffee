Spendon.Memo =
  init : () ->
    me = this
    me.updateMemo()
  
  updateMemo : () ->
    $('.memo p').click -> 
      $this = $(this)
      $this.hide()
      $this.next().show().val($this.text()).focus()

    $('.memo textarea').blur ->
      $this = $(this)
      val = $this.val()
      default_val = $this.prev().text()
      url = '/memo/update'
      if val == default_val
        $this.hide()
        $this.prev().show()
      else
        return alert('便笺的长度为1-300个字符') if val.length < 1 || val.length > 300
        $.post url, { content : val }, (data) ->
          $this.prev().text(val).show()
          $this.hide()
        , 'json'
    .keydown (e) -> 
      $(this).blur() if e.keyCode == 13

$(document).ready ->
  Spendon.Memo.init()