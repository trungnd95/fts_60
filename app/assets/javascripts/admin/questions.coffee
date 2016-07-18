# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.full_screen').on 'click', ->
    $('.layout_options').removeClass('m9')
    $('.layout_options').addClass('m12')
    $('.answers_tab').addClass('hide')
  $('.half_screen').on 'click', ->
    $('.layout_options').removeClass('m12')
    $('.layout_options').addClass('m9')
    $('.answers_tab').removeClass('hide')
  $('.row_question').on 'click', ->
    Materialize.showStaggeredList('#list-answers')
