Spendon.Category =
  init : () ->
    me = this
    me.quickCreate()
    me.editCategory()
    me.deleteCategory()

  quickCreate : () ->
    $('.categoryList a.category').click ->
      $this = $(this)
      name = $this.find('span').text()
      $dl = $('<dl></dl>')
      $dd_name = $('<dd class="category_name" data-cate_id="" title="点击分类名称进行编辑"><span></span><input type="text"></dd>')
      $dd_close = $('<dd class="close_tag">x</dd>')
      $.post '/categories/create', name : name, (data) ->
        if data.success
          $dd_name.attr('data-cate_id', data.data.id).find('span').text(name)
          $dd_name.find('input').val(name)
          $dl.append($dd_name, $dd_close)
          $('.categories_list_panel').append($dl)
      , 'json' 

  editCategory : () ->
    $('.categories_list_panel').on 'click', 'dd.category_name', () ->
      $this = $(this)
      $this.find('span').hide()
      $this.find('input').show().focus()


    $('.categories_list_panel').on 'blur', 'dd.category_name input', () ->
      $this = $(this)
      $span = $this.prev()
      val = $this.val()
      cate_id = $this.parent().data('cate_id')
      if val != $span.text() && val != ''
        $.post '/categories/'+cate_id, name : val, (data) ->
          if data.success
            $span.text(val)
            $this.val(val)
          else
            $this.val($span.text())
        , 'json' 
      $this.hide() 
      $this.prev().show()      

  deleteCategory : () ->
    $('.categories_list_panel').on 'click', 'dd.close_tag', () ->
      $this = $(this);
      cate_id = $this.prev().data('cate_id')
      if confirm('删除分类会删除该分类下所有的记录，确定删除吗？')
        $.ajax
          type : 'DELETE'
          url : '/categories/' + cate_id
          dataType : 'json'
        .done (data) ->
          $this.parent().remove() if data.success

$(document).ready ->
  Spendon.Category.init()
