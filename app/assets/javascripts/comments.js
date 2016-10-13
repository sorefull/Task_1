// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', function() {
 $(document).on('ajax:success', '#new_comment', function(xhr, data, status) {
   $('.comments').html(data);
   $('#comment_body').val('');
 });
 $(document).on('ajax:success', '.vote_comment', function(xhr, data, status) {
   $('.comments').html(data);
 });
 $(document).on('ajax:success', '.delete_comment', function(xhr, data, status) {
   $('.comments').html(data);
 });
});

// vote_comment
