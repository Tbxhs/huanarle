Spendon.Consumption =
  init : () ->
    me = this
    me.showDetail()
    me.deleteRecord()
    me.newConsumption()

  newConsumption : () ->

    genFormDom = () ->
      user_categories = Spendon.user_categories;
      $formDom = $('<div class="newConsumptionForm" />')
      $action = $('<p class="action"><input class="button newBlankLine" value="增加一列" type="button"/></p>')
      $blank = $('<div class="blank">')
      $category = $('<select class="category mr10"><option val="">请选择分类</option></select>')
      for category in user_categories
        $option = $('<option>');
        $option.val(category[0]).text(category[1])
        $category.append($option)
      $description = $('<input class="form-text w200 mr10" placeholder="消费项目" />')
      $cost = $('<img src="/assets/money16.png" class="mr10"/><input class="form-text w100" placeholder="消费金额 0.00" />')
      $blank.append($category, $description, $cost)
      $formDom.append($action, $blank)
      return $formDom

    postNewConsumption = (dialog) ->
      self = this
      $('.newConsumptionForm .blank').each ->
        $this = $(this)
        $descr = $this.find('input:first')
        $cost = $this.find('input:last')
        cost = $cost.val()
        if $descr.val().length < 1
          $descr.addClass('error_border') 
        else
          $descr.removeClass('error_border') 
        if cost.length < 1 || isNaN(cost)
          $cost.addClass('error_border')
        else
          $cost.removeClass('error_border')

      if $('.newConsumptionForm').find('.error_border').length == 0
        consumptions = []
        $('.newConsumptionForm .blank').each (index) -> 
          name = $(this).find('input:first').val()
          decimal = $(this).find('input:last').val()
          category_id = $(this).find('select').val()
          consumptions[index] = 
            name : name
            decimal : decimal
            category_id : category_id

        params = { consumptions : consumptions }
        $loading = $('<img src="/assets/loading.gif" />')
        $span = $('<span style="font-size:12px;color:green;">消费记录提交成功</span>')
        $buttonLine = $('.newConsumptionForm').find('.newBlankLine')
        $buttonLine.next('span').remove()
        $buttonLine.after($loading)
        $.post '/subjects', params, (data) ->
          if data.success
            $loading.replaceWith $span 
            $('.newConsumptionForm').find('input:text').val('')
        , 'json'
      return false  


    $('body').on 'click', 'input.newBlankLine', ->
      $this = $(this)
      $form = $this.parents('.newConsumptionForm')
      $newBlankLine = $form.find('.blank:last').clone()
      $newBlankLine.find('input').removeClass('error_border').val('')
      return alert('一次最多能添加5项消费记录') if $form.find('.blank').length >= 5
      $form.append $newBlankLine 

    $('input.newConsumption').click ->
      $.dialog 
        ok : () ->
          self = this 
          postNewConsumption(self)
        id : 'newRecordPop'
        fixed : true
        lock : true
        okValue : '确定'
        cancel : () ->
        cancelValue : '取消'
        content : genFormDom()[0]



  showDetail : () ->
    self = this
    $('a.showDetail').click ->
      url = '/subjects/' + $(this).data('subject_id')
      $.get(url, (data) ->
        Spendon.dialog $(data.html) 
      , 'json')
      return

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
          if data.success
            $this.parents('.record_line').remove()      



$(document).ready ->
  Spendon.Consumption.init()