$(document).ready ->
  $('.check_examination').on 'click', ->
    id = $(this).data('id')
    status = $(this).data('status')
    $.ajax
      beforeSend: ->
        $('.data_need_load').hide()
        $('.loading').removeClass('hide')
      url: "/admin/examinations/" + id
      type: "PUT"
      data: {examination: {id: id, status: 'checked'}}
      dataType: 'JSON'
      success: (result) ->
        $('.examination' + result.id).find('.status_load').html('checked')
        $('.examination' + result.id).find('.core_load').html(result.score)
        $('.loading').addClass('hide')
        $('.data_need_load').show
      error: (err) ->
        alert(err.status)
