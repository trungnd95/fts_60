$(document).ready ->
  $('ul.tabs').tabs('select_tab', 'tab_id')
  $('#table-subject').dataTable
    retrieve: true,
    paging: false
  $('#user_avatar').bind 'change', ->
    size_in_megabytes = this.files[0].size/1024/1024
    if size_in_megabytes > 5
      alert('Maximum file size is 5MB. Please choose a smaller file.')
  $('.exit_alert').on 'click', ->
    $(this).parent().slideUp('slow')
