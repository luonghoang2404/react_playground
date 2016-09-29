class PagesController < ApplicationController

  def index
  end

  def home
    # @records = Record.all
    # @employees = Employee.includes(:department, :manager).all
    # render json: {records: {:head => @employees.columns, :body => @employees.rows} }

    # sql_employee="SELECT a.id AS id, a.name AS name, b.name as manager, d.name as department
    #               FROM employees a
    #               LEFT OUTER JOIN employees b ON a.manager_id = b.id
    #               JOIN departments d ON a.department_id = d.id"
    # sql_department="select departments.id, departments.name as department, managers.name as manager, count(subodinates.id) as subodinates
    #                 from departments
    #                 join employees managers on managers.department_id = departments.id
    #                 join employees subodinates on subodinates.manager_id = managers.id
    #                 group by 1,2
    #                 order by 4"
    # sql_filter = "SELECT id, name FROM departments"
    # @departments_filter = ActiveRecord::Base.connection.exec_query(sql_filter).to_hash
    # @departments_filter << {"id" => 0, "name" => "All"}
    # @employees = ActiveRecord::Base.connection.exec_query(sql_employee)
    # @departments = ActiveRecord::Base.connection.exec_query(sql_department)
    # @limit =  @departments.rows.last.last
    
    # render json: {employees_header: @employees.columns, employees_data: @employees.rows, departments_header: @departments.columns, departments_data: @departments.rows, limit: @limit, departments_filter: @departments_filter}

  end
end
    