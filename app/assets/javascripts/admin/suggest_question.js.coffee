$(document).ready ->
  $('.decide_suggest_question').on 'click', 'a', ->
    id =  $(this).data('id')
    question_status = $(this).data('status')
    $.ajax
      url: '/admin/questions/' + id
      type: 'PATCH'
      data:{question: {question_status: question_status}}
      dataType: 'JSON'
      cache: false
      success: (result) ->
        alert(result.message)
        $('.suggest_question_' + result.question_id).remove()
      error: (err) ->
          alert(err.status)
    return flase
