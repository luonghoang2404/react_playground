R = React.DOM
RC = React.createElement
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
        @setState @getInitialState()
        @props.updateSignal data
        ).bind(this)


  render: ->
    R.form
      onSubmit: @handleSubmit
      className: 'form-inline pull-right'
      R.div
        className: 'form-group'
        R.input
          onChange: @handleChange
          className: 'form-control'
          type: 'text'
          name: 'name'
          value: @state.name
          placeholder: 'Please enter name'
        R.select
          name: 'department_id'
          onChange: @handleChange
          className: 'form-control'
          value: @state.department_id
          for d, index in @props.departments
            R.option 
              key: d.id
              value: d.id
              d.name
        R.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: !@valid()
          'Save'



