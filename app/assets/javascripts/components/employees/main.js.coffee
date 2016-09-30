@Main = React.createClass
  getInitialState: ->
    departments_header: []
    departments_filter: []
    departments_data: []
    employees_header: []
    total_pages: 5
    employees_data: []
    limit: 0
    page: 1
    department: 0
    

  loadDataFromServer: (page, department)->
    console.log 'load data from server'
    $.ajax
      type: 'GET'
      url: '/employees'
      dataType: 'json'
      data: {page: page, department_id: department}
      cache: false
      success: ((data) ->
        @setState limit: data.limit, departments_header: data.departments_header, 
        departments_filter: data.departments_filter,departments_data: data.departments_data, 
        employees_data: data.employees_data, total_pages: data.total_pages, employees_header: data.employees_header
        return
      ).bind(this)

  componentDidMount: ->
    @loadDataFromServer()
    # setInterval @loadDataFromServer, 2000

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

  handlePageChange: (page) ->
    @setState page: page
    @loadDataFromServer(page, @state.current_department)

  handleChangeDepartment: (department) ->
    @setState current_department: department
    @loadDataFromServer(1, department)

  render: ->
    div null,
      div className: "nav-tabs-custom",
        div className: 'tab-content',
          div className: 'tab-pane active', id: 'tab1',
            RC Table, header: @state.employees_header, data: @state.employees_data, data_for_filter: @state.departments_filter, name: 'employee', total_pages: @state.total_pages,new_employee: @handleNewEmployee, pageChange: @handlePageChange, changeDepartment: @handleChangeDepartment
          div className: 'tab-pane', id: 'tab2',
            RC Table, header: @state.departments_header, data: @state.departments_data, filter: @state.departments_filter, name: 'department', limit: @state.limit
