$(document).ready(function() {
$('.go_message').on('click', function(e) {
  e.preventDefault();

  $('<div id="dialog-form"></div>').dialog({
        autoOpen: true,
        width: 520,
        modal: true,
        open: function() {
           return $(this).load(url + ' #content');
        close: function() {
        $('#dialog-form').remove();
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });
});