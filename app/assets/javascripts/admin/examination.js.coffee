$(document).ready ->
  $('.check_examination').on 'click', ->
    id = $(this).data('id')
    status = $(this).data('status')
    $.ajax
      beforeSend: ->
        $('.data_need_load_' + id).hide()
        $('.loading_' + id).removeClass('hide')
      url: "/admin/examinations/" + id
      type: "PUT"
      data: {examination: {id: id, status: 'checked'}}
      dataType: 'JSON'
      success: (result) ->
        $('.examination_' + result.id).find('.status_load_'+ result.id).html(result.status)
        $('.examination_' + result.id).find('.score_load_' + result.id).html(result.score)
        $('.loading_' + result.id).addClass('hide')
        $('.data_need_load_' + result.id).show()
        $('.check_exam_button_' + result.id).hide()
      error: (err) ->
        alert(err.status)
