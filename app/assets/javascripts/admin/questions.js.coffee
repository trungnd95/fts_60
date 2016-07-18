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
  $(document).on 'ready page:change', ->
    $('.modal-trigger').leanModal()
  $('select[name="question[question_type]"]').on 'change', ->
    question_type =  $(this).val()
    answer_text = '<div class="text_question">'
    answer_text += '<textarea class="materialize-textarea"'
    answer_text += 'name="question[answers_attributes][0][content]"'
    answer_text += 'id="question_answers_attributes_0_content"></textarea></div>'
    if question_type == 'text'
      $('.text_question').removeClass('hide')
      $('.choise_question').addClass('hide')
      $('.answer_fields').append(answer_text)
    if question_type == 'single_choise' || question_type == 'multiple_choise'
      $('.text_question').remove()
      $('.choise_question').removeClass('hide')
      $('.add_fields').show()
    if question_type == 'single_choise' && question_type != 'multiple_choise'
      $('#answer_field input[type=checkbox]').on 'change', ->
        $('#answer_field input[type=checkbox]').not(this).prop('checked',false)
        $('#answer_field input[type=checkbox]').prop('checked',true)
  $('form.admin_new_question').on 'submit', (event) ->
    event.preventDefault()
    url = $(this).attr('action')
    data  = $(this).serialize()
    console.log(JSON.stringify(data))
    $.ajax
      url: url
      method: 'POST'
      cache: false
      data: data
      dataType: 'JSON'
      success: (result) ->
        $('.subject_body_tables').prepend(result.content)
      error: (err) ->
        str = ''
        $.each jQuery.parseJSON(err.responseText), (i, item) ->
          str += i
          str += ':  '
          str += item
          str += '\n'
        alert(str)

  $('form.edit_question').on 'submit', (event) ->
    event.preventDefault()
    url = $(this).attr('action')
    data  = $(this).serialize()
    console.log(JSON.stringify(data))
    $.ajax
      url: url
      type: 'PATCH'
      cache: false
      data: data
      dataType: 'JSON'
      success: (result) ->
        $('#question_' + result.question_id).replaceWith(result.content)
      error: (err) ->
        str = ''
        $.each jQuery.parseJSON(err.responseText), (i, item) ->
          str += i
          str += ':  '
          str += item
          str += '\n'
        alert(str)
  $('.delete_question').on 'click', ->
    id = $(this).data('id')
    url = $(this).attr('href')
    $.ajax
      url: url
      type: 'DELETE'
      data: {subject: {id: id}}
      dataType: 'JSON'
      success: (result) ->
        if(result.warning)
          alert(result.warning.message)
        else
          table = $('#table-question').DataTable()
          table.row($('#question_' + result.id)).remove().draw()
      error: (err) ->
        console.log(err.status)
    return false
