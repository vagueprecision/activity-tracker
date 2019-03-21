$(document).ready(function() {
  $timeDiv = $(document.createElement('span')).addClass('timeDiv').append(' ').append($('.hour').remove()).append(':').append($('.minute').remove());

  $('.year').after($timeDiv);

  $('.showTime').bind('change', function () {
    if ($(this).is(':checked')) {
      $('.timeDiv').show();
    }
    else {
      $('.timeDiv').hide();
      $(".hour").val('12');
      $(".minute").val('00');
    }
  });

  $('.showTime').trigger('change');
 });
