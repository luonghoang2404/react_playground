@Table = React.createClass
  getInitialState: ->
    selected: 'All'
    limit: 0
    add_new: false

  updateFilter: (new_filter_value)->
    # @setState selected: new_filter_value
    @props.changeDepartment new_filter_value

  updateLimit: (new_limit) ->
    @setState limit: new_limit

  handleUpdateSignal: (data) ->
    @props.new_employee data
    @setState selected: 'All'
    @toggle_new()

  toggle_new: ->
    value = !@state.add_new
    @setState add_new: value

  handlePageChange: (page)->
    @props.pageChange page

  render: ->
    div className: 'panel panel-success',
      div className: 'panel-heading',
        if @props.name != 'department'
          button className: 'btn btn-primary pull-right', onClick: @toggle_new,
            if @state.add_new then 'Cancel' else 'Add New'
        if @props.name != 'department'
          if @state.add_new
            RC NewEmployee, departments: @props.data_for_filter, updateSignal: @handleUpdateSignal
          else
            RC Filter, data: @props.data_for_filter, selected: @state.selected, changeFilter: @updateFilter
        else
          RC Slider, limit: @state.limit, updateLimit: @updateLimit, limit: @props.limit
      div className: 'panel-body',
        if @props.name == 'employee'
          div style: {textAlign: 'center'},
            RC Pagination, total_pages: @props.total_pages,pageChange: @handlePageChange
        table className: 'table table-condensed table-striped',
          thead null,
            tr className: 'info',
              for head, index in @props.header
                th key: index,
                  h4 null, head,
          tbody null,
            for row in @props.data
              if @props.name == 'department'
                if row[3] >= @state.limit
                  RC Row, key: row[0], data: row
              else
                # if @state.selected=='All' || @state.selected==row[3]
                RC Row, key: row[0], data: row
