$(document).ready( function(){
  $('.js-datepicker').each( function(){
    $(this).datepicker({
      format: 'd MM yyyy'
    });
  });
});
