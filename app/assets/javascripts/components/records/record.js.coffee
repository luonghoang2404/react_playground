{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM

@Record = React.createClass
  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record

  handleEdit: (e) ->
    e.preventDefault()
    data = 
      title: ReactDOM.findDOMNode(@refs.title).value
      date: ReactDOM.findDOMNode(@refs.date).value
      amount: ReactDOM.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data: 
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data
  
  recordForm: ->
    tr null,
      td null,
        input className: 'form-control', type: 'text', defaultValue: @props.record.date, ref: 'date'
      td null,
        input className: 'form-control', type: 'text', defaultValue: @props.record.title, ref: 'title'
      td null,
        input className: 'form-control', type: 'number', defaultValue: @props.record.amount, ref: 'amount'
      td null,
        a className: 'btn btn-default', onClick: @handleEdit, 'Update'
        a className: 'btn btn-danger', onClick: @handleToggle, 'Cancel'

  recordRow: ->
    tr null,
      td null, @props.record.date
      td null, @props.record.title
      td null, amountFormat(@props.record.amount)
      td null,
        a className: 'btn btn-default', onClick: @handleToggle, 'Edit'
        a className: 'btn btn-danger', onClick: @handleDelete, 'Delete'

  render: ->
    if @state.edit then @recordForm() else @recordRow()