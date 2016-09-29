{ form, div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM
RC = React.createElement

@RecordForm = React.createClass
  getInitialState: ->
    title: ""
    date: ""
    amount: ""
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  valid: ->
    @state.title && @state.date && @state.amount

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/records', { record: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
      , 'JSON'

  render: ->
    form className: 'form-inline', onSubmit: @handleSubmit,
      div className: 'form-group',
        input className: 'form-control', type: 'date', name: 'date', value: @state.date, placeholder: 'Date', onChange: @handleChange
      div className: 'form-group',
        input className: 'form-control', type: 'text', name: 'title', value: @state.title, placeholder: 'Title', onChange: @handleChange,
      div className: 'form-group',
        input className: 'form-control', type: 'number', name: 'amount', value: @state.amount, placeholder: 'Amount', onChange: @handleChange
      button className: 'btn btn-primary', type: 'submit', disabled: !@valid(), 'Create Record',
        
        
        
        
