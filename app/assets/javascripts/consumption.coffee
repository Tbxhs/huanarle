Spendon.Consumption =
  init : () ->
    me = this
    me.showDetail()
    me.addNewRecordLine()
    me.removeRecordLine()
    me.deleteRecord()
    me.newRecord()
    $('dl.NewRecordForm').find('input').not('.button').val('')

  showDetail : () ->
    self = this
    $('a.showDetail').click ->
      url = '/subjects/' + $(this).data('subject_id')
      $.get(url, (data) ->
        Spendon.dialog $(data.html) 
      , 'json')
      return

  addNewRecordLine : () ->
    $('dl.new_record_form').on 'click', 'a.add_new_line', () -> 
      dd_counts = $('dd.blanks').length
      if dd_counts >= 15
        alert '一次最多能添加15项消费记录'
      else
        $parent = $(this).parents('dd')
        $dd = $parent.clone()
        $dd.find('input').val('')
        $parent.after $dd

  removeRecordLine : () ->
    $('dl.new_record_form').on 'click', 'a.remove_record_line', () ->
      if $('dd.blanks').length == 1
        alert '至少填写一项消费记录'
      else
        $(this).parents('dd').remove()

  deleteRecord : () -> 
    self = this
    $('a.delBtn').click ->
      $this = $(this)
      if confirm('确定删除吗？')
        $.ajax
          type : 'DELETE'
          url : '/subjects/' + $(this).data('subject_id')
          dataType : 'json'
        .done (data) ->
          console.log data
          if data.success
            $this.parents('.record_line').remove()      

  newRecord : () ->
    self = this
    setStatus = (status = true, $input, msg = '不能为空') ->
      if status
        $input.removeClass 'error_border'
        $input.parent().next().text('').removeClass('error')
      else
        $input.addClass 'error_border' 
        $input.parent().next().text(msg).addClass('error')

    validateDecimal = () ->
      $inputs = $('input.money');
      $inputs.each ->
        $this = $(this)
        val = $this.val()
        if !isNaN(val) && val.length > 0
          $this.removeClass('error_border')
        else
          $this.addClass('error_border')

    validateRecordName = () ->
      $inputs = $('input.description');
      $inputs.each ->
        if $(this).val().length < 1
          $(this).addClass('error_border')
        else
          $(this).removeClass('error_border')

    validateTitle = () ->
      $input = $('input.record_title')
      val = $input.val()
      if val.length < 1
        setStatus(false, $input)
      else
        setStatus(true, $input)

    $('input.new_record_submit').click ->
      validateTitle()
      validateRecordName()
      validateDecimal()
      consumptions = []
      $('input.description').each (index) ->
        name = $(this).val()
        decimal = $(this).next().next().val()
        if name.length > 1 && decimal.length > 1 && $(this).parents('dd').find('.error_border').length < 1
          consumptions[index] = 
            name : $(this).val()
            decimal : $(this).next().next().val()

      $dd = $('dd.blanks:last').next()
      if $('dd.blanks').find('.error_border').length > 0
        $dd.find('p').text('消费项目不能为空 消费金额只能为数字且不能为空').addClass('error')
      else
        $dd.find('p').text('')

      params = 
        title : $('input.record_title').val()
        remarks : $('textarea.remarks').val()
        consumptions : consumptions

      if $('.new_record_form').find('.error_border').length == 0
        $('span.loading').text('提交中...')
        $.post '/subjects', params, (data) -> 
          window.location.reload() if data.success
        , 'json'




$(document).ready ->
  Spendon.Consumption.init()