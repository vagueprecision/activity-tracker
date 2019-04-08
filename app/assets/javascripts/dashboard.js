$(document).ready(function() {
   $('#sort').bind('change', function () {
     $('.goal_list').load('/goals/card_list?sort=' + $(this).val());
   });

   $('#sort').trigger('change');
 });
