Spendon.SignUpAndSignIn =
  init : () ->
    me = this
    me.__bindSignUp()
    me.__bindSignIn()

  __bindSignIn : () ->
    $form = $('form.signIn');
    $form.find('.email').focus ->
      $this = $(this)
      if $this.val() == $this.attr('default_text')
        $this.val('')
    .blur ->
      $this = $(this)
      if $this.val().length == 0
        $this.val $this.attr('default_text')

    $form.find('.password').focus ->
      $this = $(this)
      $this.hide()
      $this.next().show().focus()

    $form.find('.password_input').blur -> 
      $this = $(this)
      if $this.val().length == 0
        $this.hide()
        $this.prev().show()
        
    $form.find('.submit').click ->
      if $('.email').val().length > 0 && $('.password_input').val().length > 0
        $form.submit()

  __bindSignUp : () ->
    $form = $('form.signUp')

    _focus = ($input) ->
      val = $input.val()
      default_val = $input.attr('default_text')
      if val == default_val
        $input.val('')

    _blur = ($input) ->
      val = $input.val()
      default_val = $input.attr('default_text')
      if val == ''
        $input.val(default_val)

    _validate = ($input) ->
      val = $input.val()
      default_text = $input.attr('default_text')
      if $input.hasClass('login_name')
        if (val.length > 20 || val.length < 6 || val == default_text)
          $input.addClass 'error_border'
        else
          $input.removeClass 'error_border'
      else if $input.hasClass('password_input')
        if (val.length > 20 || val.length < 6)
          $input.prev().addClass 'error_border'
          $input.addClass 'error_border'           
        else
          $input.prev().removeClass 'error_border'
          $input.removeClass 'error_border'
      else if $input.hasClass('email')
        if !val.match(/^[0-9a-zA-Z_\-\.]+@[0-9a-zA-Z_\-]+(\.[0-9a-zA-Z_\-]+)+$/)
          $input.addClass 'error_border'
        else               
          $input.removeClass 'error_border'

    $form.find('.email').focus ->
      _focus $(this)
    .blur ->
      _blur $(this)
      _validate $(this)

    $form.find('.login_name').focus ->
      _focus $(this)
    .blur -> 
      _blur $(this)
      _validate $(this)

    $form.find('.password').focus ->
      $(this).hide()
      $(this).next().show().focus()
    $form.find('.password_input').blur ->
      if $(this).val().length == 0
        $(this).hide()
        $(this).prev().show()
      _validate $(this)

    $form.find('.submitBtn').click ->
      _validate $('.password_input')
      _validate $('.login_name')
      _validate $('.email') 
      if $form.find('.error_border').length == 0
        $form.submit();

$(document).ready ->
  Spendon.SignUpAndSignIn.init()