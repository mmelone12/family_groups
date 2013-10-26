$(function(){
  $('.avatar_select').click(function(){
    $(this).hide( "drop", { direction: "up" }, "slow" );
    });
});  

$(document).ready(function() {
  $('#create_user').click(function(e) {
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
      autoOpen: false,
      width: 520,
      modal: true,
      open: function() {
        return $(this).load(url + ' #content');
      },
      close: function() {
        $('#dialog-form').remove();
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});
