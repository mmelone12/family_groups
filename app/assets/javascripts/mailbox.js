$('b-compose').on('click', function(e) {
  e.preventDefault();

  $('<div id="dialog-form"></div>').dialog({
        autoOpen: true,
        width: 680,
        modal: true,
        open: function() {
            $(this).append($("<%= escape_javascript(render(:partial => 'sent/compose')) %>"));
        },
        close: function() {
        $('#dialog-form').remove();
      }
    });
    dialog_form.dialog('open');
    e.preventDefault();
  });