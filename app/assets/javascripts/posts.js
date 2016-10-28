// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('turbolinks:load', function() {
 $(document).on('ajax:success', '.vote', function(xhr, data, status) {
   $('.show_post').html(data);
 });
 $(document).on('ajax:success', '.edit_comment', function(xhr, data, status) {
   $(this).parent().parent().parent().parent().parent().html(data);
 });
});
