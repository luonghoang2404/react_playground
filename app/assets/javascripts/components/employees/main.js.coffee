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
    $.ajax
      type: 'GET'
      url: '/employees'
      dataType: 'json'
      cache: false
      success: ((data) ->
        @setState limit: data.limit
        @setState departments_header: data.departments_header
        @setState departments_filter: data.departments_filter
        @setState departments_data: data.departments_data
        @setState employees_data: data.employees_data
        @setState employees_header: data.employees_header
        return
      ).bind(this)

  componentDidMount: ->
    @loadCommentFromServer()

    # setInterval @loadCommentFromServer, @props.pollInterval


  handleNewEmployee: (employee)->
    employees = @state.employees_data
    employees.unshift(employee)
    @setState employees_data: employees

    departments = @state.departments_data
    i = 0
    while departments[i][1] != employee[3]
      i += 1
    
    departments[i][3] += 1
    @setState departments_data: departments
    # @loadCommentFromServer()

  render: ->
    R.div null,
      R.div
        className: "nav-tabs-custom"
        R.ul
          className: "nav nav-tabs"
          R.li
            className: 'active'
            R.a
              href:'#tab1'
              'data-toggle': 'tab'
              'Employees'
          R.li null,
            R.a
              href:'#tab2'
              'data-toggle': 'tab'
              'Department'
        R.div
          className: 'tab-content'
          R.div
            className: 'tab-pane active'
            id: 'tab1'
            RC Table, header: @state.employees_header, data: @state.employees_data, data_for_filter: @state.departments_filter, name: 'employee', new_employee: @handleNewEmployee
          R.div
            className: 'tab-pane'
            id: 'tab2'
            RC Table, header: @state.departments_header, data: @state.departments_data, filter: @state.departments_filter, name: 'department', limit: @state.limit
