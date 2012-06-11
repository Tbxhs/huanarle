Spendon.NewRecord = {
  init : function () {
    var me = this;
    // me.__bindNewRecordBtnClickEvent();
  },

  __bindNewRecordBtnClickEvent : function () {
    var $button = $('a.new_record');

    var newRecordPop = function () {
      var $content = $('<div class="newRecordPanel"></div>');
      return $content[0];
    };

    $button.click(function () {
      $.dialog({
        ok : function(){},
        id : 'newRecordPop',
        fixed : true,
        lock : true,
        okValue : '确定',
        content : newRecordPop()
      });
    });

  }

};

$(function () {
  Spendon.NewRecord.init();
})