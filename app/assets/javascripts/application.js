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
  var url = window.location.href
    , id  = parseInt(url.substring(url.lastIndexOf('/') + 1))

  var handleKeyUp = function(e) {
    if (e.keyCode == 67) {
      $($('#todos li')[0]).find('a').click()
    }
  }

  var getURLParameter = function(name) {
    return decodeURI(
      (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
  }

  var bindBIPSuccess = function() {
    $('.best_in_place').bind('ajax:success', function() {
      // New/edit form
      if ($(this).parents('#info').length > 0) {
        var completed = getURLParameter('completed')
          , tags      = getURLParameter('tags')

        if (completed == 'null') { completed = false }

        $.get('/tags', { tags: tags }, function(tags) {
          $('#tags').html(tags)
        })

        $.get('/', { tags: tags, completed: completed }, function(tasks) {
          $('#content').html(tasks)
        })
      }

      // Completed checkbox
      if ($(this).attr('data-type') === 'checkbox') {
        var li = $(this).parents('li')

        if (li.hasClass('completed')) {
          li.fadeTo('slow', 1).removeClass('completed')
        } else {
          li.fadeTo('slow', 0.5).addClass('completed')
        }
      }
    })
  }
  
  $('a[data-pjax]').pjax()
  $('.best_in_place').best_in_place()
  bindBIPSuccess()

  $(document).on('pjax:end', function(ev) {
    $('ul#todos li').removeClass('selected')
    $(ev.relatedTarget).parents('li').addClass('selected')
    
    $('#info').show()

    if ($('#todo_title')) {
      $('#todo_title').focus()

      bindBIPSuccess()
    }
  })

  if (id) {
    $('#todos li[data-id="' + id + '"]').find('a').click()
  }
  
  document.addEventListener('keyup', handleKeyUp, false)
})
