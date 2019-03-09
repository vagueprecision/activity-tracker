$(document).ready(function() {
   $('.activitySelect').bind('change', function () {
     $newActivity = $(this).parent().find('.newActivity');
     if ($(this).val() == "")
      $newActivity.show();
    else
      $newActivity.hide();
   });

   $('.activitySelect').trigger('change');
 });
