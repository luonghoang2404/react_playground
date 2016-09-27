R = React.DOM
RC = React.createElement
@Slider = React.createClass
  getInitialState: ->
    limit: 0
  # handleFilter: (e)->
  #   @setState selected: e.target.value
  #   @props.changeFilter e.target.value

  handleChange: (e)->
    @setState limit: e.target.value
    @props.updateLimit e.target.value


  render: ->
    R.div null,
      R.h4 null,
        "Minimum number of employees: #{@state.limit}"
      R.input
        type: 'range'
        name: 'points'
        min: 0
        max: @props.limit
        defaultValue: 0
        onChange: @handleChange


