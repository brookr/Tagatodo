// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or cripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.pjax
//= require bootstrap
//= require best_in_place

$(function() {
  $('a[data-pjax]').pjax()

  $('.best_in_place').best_in_place()

  var url = window.location.href
    , id  = url.substring(url.lastIndexOf('/') + 1)

  if (id) {
    var link = $('#todos li[data-id="' + id + '"]').find('a')

    link.click()
  }
})
