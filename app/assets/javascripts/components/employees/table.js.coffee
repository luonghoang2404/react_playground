R = React.DOM
RC = React.createElement
@Table = React.createClass
  getInitialState: ->
    selected: 'All'
    limit: 0
    add_new: false

  updateFilter: (new_filter_value)->
    @setState selected: new_filter_value

  updateLimit: (new_limit) ->
    @setState limit: new_limit

  handleUpdateSignal: (data) ->
    @props.new_employee data
    @setState selected: 'All'
    @toggle_new()

  toggle_new: ->
    value = !@state.add_new
    @setState add_new: value

  render: ->
    R.div
      className: 'panel panel-success'
      R.div
        className: 'panel-heading'
        if @props.name != 'department'
          R.button
            className: 'btn btn-primary pull-right'
            onClick: @toggle_new
            if @state.add_new
              'Cancel'
            else
              'Add New'
        if @props.name != 'department'
          if @state.add_new
            RC NewEmployee, departments: @props.data_for_filter, updateSignal: @handleUpdateSignal
          else
            RC Filter, data: @props.data_for_filter, selected: @state.selected, changeFilter: @updateFilter
        else
          RC Slider, limit: @state.limit, updateLimit: @updateLimit, limit: @props.limit
      R.div
        className: 'panel-body'
        R.table
          className: 'table table-condensed table-striped'
          R.thead null,
            R.tr
              className: 'info'
              for head, index in @props.header
                R.th
                  key: index
                  R.h4 null,
                    head
          R.tbody null,
            for row in @props.data
              if @props.name == 'department'
                if row[3] >= @state.limit
                  RC Row, key: row[0], data: row
              else
                if @state.selected=='All' || @state.selected==row[3]
                  RC Row, key: row[0], data: row
