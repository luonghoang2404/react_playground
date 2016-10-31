@BoilingVerdict = (props) ->
  if props.celsius >= 100
    p {}, "The water would boil."
  else
    p {}, "The water would not boil."

@toCelsius = (f) ->
  (f - 32) *5 / 9

@toFahrenheit = (c) ->
  (c * 9 / 5) + 32

@tryConvert = (value, convert) ->
  convert(value)

scaleNames =
  c: 'Celsius'
  f: 'Fahrenheit'

@TemperatureInput = React.createClass
  handleChange: (e) ->
    @props.updateValue e.target.value

  render: ->
    div className:'form-group',
      label className:'control-label', "Enter temperature in #{scaleNames[@props.scale]}:",
      input
        className: 'form-control'
        type: 'number'
        value: @props.value
        onChange: @handleChange

@Calculator = React.createClass
  getInitialState: ->
    scale: ''
    value: ''

  handleUpdateValueC: (value) ->
    @setState scale: 'c', value: value

  handleUpdateValueF: (value) ->
    @setState scale: 'f', value: value

  render: ->
    celsius = if @state.scale == 'f' then tryConvert(@state.value, toCelsius) else @state.value
    fahrenheit = if @state.scale == 'c' then tryConvert(@state.value, toFahrenheit) else @state.value
    div {},
      RC TemperatureInput, scale: 'c', value: celsius, updateValue: @handleUpdateValueC
      RC TemperatureInput, scale: 'f', value: fahrenheit, updateValue: @handleUpdateValueF
      RC BoilingVerdict, celsius: celsius