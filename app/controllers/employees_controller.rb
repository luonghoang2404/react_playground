class EmployeesController < ApplicationController
  def create
    @department = Department.find(params[:employee][:department_id])
    @manager = @department.employees.find_by(manager_id: nil)
    @employee = @department.employees.create(name: params[:employee][:name], manager_id: @manager.id)
    render json: {record: [@employee.id, @employee.name, @manager.name, @department.name]}
  end

  def index

    page = params[:page].to_i
    if page == 0
      page = 1
    end
    limit = 10;
    offset = limit*(page-1);

    department_id = params[:department_id]
    if department_id.blank? || department_id == '0'
      extra_sql = ''
    else
      extra_sql = ' WHERE d.id = ' + department_id
    end
    sql_employee="SELECT a.id AS id, a.name AS name, b.name as manager, d.name as department
                  FROM employees a
                  LEFT OUTER JOIN employees b ON a.manager_id = b.id
                  JOIN departments d ON a.department_id = d.id" + 
                  extra_sql + 
                  " GROUP BY 1,2,3,4
                  ORDER BY a.created_at DESC 
                  LIMIT #{limit} OFFSET #{offset}"
    sql_employee_count="SELECT COUNT(a.id)
                  FROM employees a
                  LEFT OUTER JOIN employees b ON a.manager_id = b.id
                  JOIN departments d ON a.department_id = d.id" + extra_sql
                  
    sql_department="select departments.id, departments.name as department, managers.name as manager, count(subodinates.id) as subodinates
                    from departments
                    join employees managers on managers.department_id = departments.id
                    join employees subodinates on subodinates.manager_id = managers.id
                    group by 1,2,3
                    order by 4"

    sql_filter = "SELECT id, name FROM departments"

    @departments_filter = ActiveRecord::Base.connection.exec_query(sql_filter).to_hash
    @departments_filter << {"id" => 0, "name" => "All"}
    @employees = ActiveRecord::Base.connection.exec_query(sql_employee)
    @total_employees = ActiveRecord::Base.connection.exec_query(sql_employee_count)
    @total_pages = (@total_employees.rows.first.first.to_f / limit).round(0)
    if @total_pages == 0
      @total_pages = 1
    end
    @departments = ActiveRecord::Base.connection.exec_query(sql_department)
    @limit =  @departments.rows.last.last

    render json: { employees_header: @employees.columns, employees_data: @employees.rows, departments_header: @departments.columns, departments_data: @departments.rows, limit: @limit, departments_filter: @departments_filter, total_pages: @total_pages }
  end
end
