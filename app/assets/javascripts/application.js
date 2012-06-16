// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require 'jquery.artDialog.min'
Spendon = window.Spendon = {};
Spendon.toggleSettingDropDown = function () {
  $('a.dropdown-toggle').click(function () {
    var $this = $(this),
        $dropdownm = $this.next();

    $this.toggleClass('actived');
    if ($dropdownm.is(':hidden')) {
      $dropdownm.show();
    } else {
      $dropdownm.hide();
    }
  });
};

Spendon.dialog = function ($dom) {
  $.dialog({
    ok : function(){},
    id : 'newRecordPop',
    fixed : true,
    lock : true,
    okValue : '确定',
    content : $dom[0]
  });
};

$(function () {
  Spendon.toggleSettingDropDown();
});