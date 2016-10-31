scaleNames = 
  c: 'Celsius'
  f: 'Fahrenheit'

@toCelsius = (f) ->
  (f - 32) * 5 / 9

@toFahrenheit = (c) ->
  (c * 9 / 5) + 32 

@tryConvert = (value, convert) ->
  input = parseFloat(value)
  if Number.isNaN(input)
    return ''
  output = convert(input)
  rounded = Math.round(output * 1000) / 1000
  rounded.toString()

@BoilingVerdict = (props) ->
  if props.celsius >= 100
    p null, 'The water would boil',
  else
    p null, 'The water would not boil',

@TemperatureInput = React.createClass
  handleChange: (e) ->
    @props.onChange e.target.value
  render:
    fieldset null,
      legend, null, "Enter temperature in #{scaleNames[@props.scale]}:"
      input value:#{@props.value}, onChange: @handleChange,

@Calculator = React.createClass
  getInitialState: ->
    scale: 'c'
    value: ''

  handleCelsiusChange: (value) ->
    @setState
      scale: 'c'
      value: value

  handleFahrenheitChange: ->
    @setState
      scale: 'f'
      value: value

  render: ->
    scale = @state.scale
    value = @state.value
    celsius = if scale == 'f' then tryConvert(value, toCelsius) else value
    fahrenheit = if scale == 'c' then tryConvert(value, toFahrenheit) else value







class Calculator extends React.Component {
  constructor(props) {
    super(props);
    this.handleCelsiusChange = this.handleCelsiusChange.bind(this);
    this.handleFahrenheitChange = this.handleFahrenheitChange.bind(this);
    this.state = {value: '', scale: 'c'};
  }

  handleCelsiusChange(value) {
    this.setState({scale: 'c', value});
  }

  handleFahrenheitChange(value) {
    this.setState({scale: 'f', value});
  }

  render() {
    const scale = this.state.scale;
    const value = this.state.value;
    const celsius = scale === 'f' ? tryConvert(value, toCelsius) : value;
    const fahrenheit = scale === 'c' ? tryConvert(value, toFahrenheit) : value;

    return (
      <div>
        <TemperatureInput
          scale="c"
          value={celsius}
          onChange={this.handleCelsiusChange} />
        <TemperatureInput
          scale="f"
          value={fahrenheit}
          onChange={this.handleFahrenheitChange} />
        <BoilingVerdict
          celsius={parseFloat(celsius)} />
      </div>
    );
  }
}

ReactDOM.render(
  <Calculator />,
  document.getElementById('root')
);
