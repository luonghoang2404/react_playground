{ div, h3, h4, h5, table, tbody, tr, td, a, i, input, select, option, span, button, img } = React.DOM
RC = React.createElement
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


