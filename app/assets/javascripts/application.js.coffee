# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require bootstrap-sprockets
#= require bootstrap3-editable/bootstrap-editable
#= require dataTables/jquery.dataTables
#= require dataTables/extras/dataTables.colReorder
#= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
#= require select2
#= require gritter
#= require moment
#= require jquery.easypiechart
#= require dataTables.select.min
#= require_tree .
#= require_self


$(document).ready ->
  window.peseidon.on_edit_line_detail()
  return

window.peseidon = {}

window.peseidon.on_edit_line_detail = ->
  $('a[data-behaviour=\'editable\']').editable
    params: (params) ->
      params['_method'] = 'put'
      params[$(this).data('resource') + '[' + params.name + ']'] = params.value
      params
    success: (resource, newValue) ->

window.peseidon.initUserActivityCounts = ->
  $.ajax
    url: $('#activities_counts_path').val()
    success: (response) ->
      $.each response, (key, val) ->
        $('#' + key).children().first().text val[0]
        $('#' + key).attr 'data-percent', 100 * val[0] / val[1]
        return
      InitiateEasyPieChart.init()


window.peseidon.mergeResource = (merge_url) ->
  resource_ids = $('#resources_datatable').DataTable().rows({selected: true}).ids().toArray()
  if(resource_ids.length > 1)
    $.ajax
      url: merge_url
      type: "patch"
      data:
        ids: resource_ids

      success: (response) ->
        location.reload()
        return
  else
    alert('select something')

window.peseidon.selection_within_scope = (selector, other, source_url) ->
  $(document).off 'change', selector
  $(document).on 'change', selector, ->
    $.ajax
      url: source_url
      dataType: "json"
      data:
        parent_id: $(this)[0].value

      success: (response) ->
        $(other).select2('val', '')
        $(other).find('option')
        .remove()
        .end()

        $(response).each (i, v) ->
          $(other).append $('<option>',
            value: v.value
            html: v.text)
        return
    return
