$(document).ready ->
  $('.delete_subject').on 'click', ->
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
          table = $('#table-subject').DataTable()
          table.row($('.row-' + result.id)).remove().draw()
      error: (err) ->
        console.log(err.status)
    return false
