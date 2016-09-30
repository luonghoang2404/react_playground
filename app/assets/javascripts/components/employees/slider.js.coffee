@Slider = React.createClass
  getInitialState: ->
    limit: 0

  handleChange: (e)->
    @setState limit: e.target.value
    @props.updateLimit e.target.value

  render: ->
    div null,
      h4 null, "Minimum number of employees: #{@state.limit}"
      input type: 'range', name: 'points', min: 0, max: @props.limit, defaultValue: 0, onChange: @handleChange,


