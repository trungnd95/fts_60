$(document).ready ->
  $('ul.tabs').tabs('select_tab', 'tab_id')
  $('#table-subject').dataTable
    retrieve: true,
    paging: false
