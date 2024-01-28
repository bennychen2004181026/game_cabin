$(document).ready(function() {
  $('#clear-data-and-home').on('click', function() {
    $.ajax({
      url: '/clear',
      method: 'DELETE',
      success: function() {
        window.location.href = '/';
      }
    });
  });
});