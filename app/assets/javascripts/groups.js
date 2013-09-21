$(document).ready(function() {
  $('#create_group').click(function(e) {
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

$('.groups_showme1').on('click', function(e) {
  e.preventDefault();

  $('<div id="dialog-form">Loading</div>').dialog({
        autoOpen: true,
        width: 520,
        modal: true,
        open: function() {
            $(this).append($('#groups_show'1).show());
        },
        close: function() {

        }
    });
});

 $('.groups_showme5').on('click', function(e) {
    e.preventDefault();
    $('#groups_show5').show();
      var htmlString = $(this).html();
      var dialog_form = $('<div id="dialog-form">Loading</div>').dialog({
      autoOpen: false,
      width: 520,
      modal: true,
      open: function() {
        return $(this).html( htmlString );
      },
      close: function() {
        $('#dialog-form').remove();
      }
  });

    dialog_form.dialog('open');
      return false;
  });

  $( "#dialog-modal" ).dialog({
    height: 140,
    modal: true
  });

  $('.groups_showme4').on('click', function(e) {
    e.preventDefault();
    $('#groups_show4').show();
     win = new Window({title: "Share This", width:200, height:150, destroyOnClose: true, recenterAuto:false});
     win.setContent('#groups_show4',true,true);
      win.show();
      return false;
  });

    $('.groups_showme2').on('click', function(e) {
    e.preventDefault();
    $('#groups_show2').show();
      var dialog_form = $('<div id="dialog-form">Loading<div id="groups_show"></div></div>').dialog({
      autoOpen: false,
      width: 520,
      modal: true,
      open: function() {
        return $(this).load("groups/group_full2" + '#groups_show2');
      },
      close: function() {
        $('#dialog-form').remove();
      }
    });
    dialog_form.dialog('open');
      return false;
  });
});