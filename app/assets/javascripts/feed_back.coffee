Spendon.FeedBack =
  init : () ->
    me = this
    me.newFeedBack()

  newFeedBack : () ->
    $('.feedBack').click ->
      $dom = $('<div style="font-size:12px; color:#999999; text-align:center;" align=center>')
      $text = $('<p style="margin-bottom: 5px;">非常感谢你的宝贵意见和建议，请在下方填写 :) </p>')
      $textarea = $('<textarea style="width:300px; height:180px; border:1px solid #CCC;" class="feedBackContent">')
      $dom.append($text, $textarea);
      $.dialog
        ok : () ->
          $.post '/feed_backs', { content : $('.feedBackContent').val() }
          return true
        id : 'feedBack'
        fixed : true
        lock : true
        okValue : '确定'
        cancelValue : '取消'
        cancel : () -> 
        content : $dom[0]

$(document).ready ->
  Spendon.FeedBack.init()
