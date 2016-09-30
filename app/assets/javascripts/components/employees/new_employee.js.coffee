@NewEmployee = React.createClass
  getInitialState: ->
    name: ''
    department_id: 0

  valid: ->
    @state.name && @state.department_id>0

  handleChange: (e)->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e)->
    e.preventDefault()
    $.ajax
      type: 'POST'
      url: '/employees'
      data: {employee: @state}
      success: ((data) ->
        console.log(data.record)
        @setState @getInitialState()
        @props.updateSignal data.record
        ).bind(this)

  render: ->
    form className: 'form-inline', onSubmit: @handleSubmit,
      div className: 'form-group',
        input
          className: 'form-control'
          type: 'text'
          name: 'name'
          value: @state.name
          placeholder: 'Please enter name'
          onChange: @handleChange
        select className: 'form-control', name: 'department_id', onChange: @handleChange, value: @state.department_id,
          for d, index in @props.departments
            option key: d.id, value: d.id, d.name,
        button className: 'btn btn-primary', type: 'submit', disabled: !@valid(), 'Save',
          
          
          
          



