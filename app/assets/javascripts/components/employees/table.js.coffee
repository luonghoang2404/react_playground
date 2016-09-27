R = React.DOM
RC = React.createElement
@Table = React.createClass
  getInitialState: ->
    selected: 'All'
    limit: 0

  updateFilter: (new_filter_value)->
    @setState selected: new_filter_value

  updateLimit: (new_limit) ->
    @setState limit: new_limit

  handleUpdateSignal: (data) ->
    @props.new_employee data

  render: ->
    R.div null,
      R.h1 null,
        @props.name
      if @props.name != 'department'
        RC NewEmployee, departments: @props.data_for_filter, updateSignal: @handleUpdateSignal
      R.div
        className: 'panel-success'
        if @props.name == 'department'
          RC Slider, limit: @state.limit, updateLimit: @updateLimit, limit: @props.limit
        else
          RC Filter, data: @props.data_for_filter, selected: @state.selected, changeFilter: @updateFilter
            ,
      R.hr
      R.table
        className: 'table table-condensed'
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
