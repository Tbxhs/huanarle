Spendon.Blog =
  init : () ->
    me = this
    me.newBlog()

  newBlog : () ->
    editor_a = new baidu.editor.ui.Editor()
    editor_a.render('myEditor')
    $('.new_blog_form .submit').click ->
      editor_a.sync()
      title = $('#blog_title').val()
      content = editor_a.getContent()     
      if title.length == 0
        $('#blog_title').addClass('error_border')
      if title.length > 0 && content != '<p><br /></p>'
        $(this).parents('form').submit()


$(document).ready ->
  Spendon.Blog.init()
