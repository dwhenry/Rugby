$(function() {
  function selectPrevElement() {
    // select the previous radio element
    $(this).prev().click();
    $(this).parent().children('input[type="text"]').attr({name: 'temp'})
    $(this).attr({name: 'picks[1][margin]'})
  }

  // when textbox is used, select the previous checkbox
  $('.pick_row input[type="text"]').on('click', selectPrevElement);
  $('.pick_row input[type="text"]').on('keydown', selectPrevElement);
});

