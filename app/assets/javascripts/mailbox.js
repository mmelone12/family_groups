$(document).ready(function() {
  $('#go_inbox').click(function(e) {
    
    var url = $(this).attr('href');
    var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
      autoOpen: true,
      width: 520,
      modal: true,
      open: function() {
        return $(this).load(url + ' #content');
      },
  });

    dialog_form.dialog('open');
    e.preventDefault();
  });
});