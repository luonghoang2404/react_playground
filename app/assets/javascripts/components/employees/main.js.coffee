{ div, h3, h4, h5, table, thead, tbody, tr, th, td, a, i, input, select, option, span, button, img } = React.DOM
R = React.DOM
RC = React.createElement
@Main = React.createClass
  getInitialState: ->
    departments_header: []
    departments_filter: []
    departments_data: []
    employees_header: []
    employees_data: []
    limit: 0

  loadCommentFromServer: ->
    console.log 'load data from server'
    $.ajax
      type: 'GET'
      url: '/employees'
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState limit: data.limit, departments_header: data.departments_header, 
        departments_filter: data.departments_filter,departments_data: data.departments_data, 
        employees_data: data.employees_data, employees_header: data.employees_header
        return
      ).bind(this)

  componentDidMount: ->
    @loadCommentFromServer()
    # setInterval @loadCommentFromServer, 2000

  handleNewEmployee: (employee)->
    # Add employee to the list
    employees = @state.employees_data
    employees.unshift(employee)
    @setState employees_data: employees
    # Adjust number of employees for the department
    departments = @state.departments_data
    i = 0
    while departments[i][1] != employee[3]
      i += 1
    departments[i][3] += 1
    @setState departments_data: departments

  render: ->
    div null,
      div className: "nav-tabs-custom",
        div className: 'tab-content',
          div className: 'tab-pane active', id: 'tab1',
            RC Table, header: @state.employees_header, data: @state.employees_data, data_for_filter: @state.departments_filter, name: 'employee', new_employee: @handleNewEmployee
          div className: 'tab-pane', id: 'tab2',
            RC Table, header: @state.departments_header, data: @state.departments_data, filter: @state.departments_filter, name: 'department', limit: @state.limit
