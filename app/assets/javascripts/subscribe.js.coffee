$(document).ready ->

  tag = $('#subscribe form')
  field = $('#subscribe #subscribe_email')
  success_notice = 'Check your email and confirm your subscribtion'
  success_class = 'class="popup_succes"'
  error_class = 'class="popup_error"'
  error_notice = 'Email already taken'
  popup = (arg, cl) ->
    $('body').append('<div class="popup_dialog"><div class="popup_wrap"><p ' + cl + '>' + arg + '</p>'\
    + '<div class="popup_close"></div></div></div>')


  tag.on 'submit', ->
    if field.val() == ''
      return false
    $('#submit-subscribe').addClass('loading')

  tag.on 'ajax:success', (e, data, status, xhr) ->
    $('#submit-subscribe').removeClass('loading')
    field.val('')
    popup(success_notice, success_class)

  tag.on 'ajax:error', (e, data, status, xhr) ->
    $('#submit-subscribe').removeClass('loading')
    field.val('')
    popup(error_notice, error_class)

  $(document).on 'click', '.popup_close', ->
    $('.popup_dialog').remove()
