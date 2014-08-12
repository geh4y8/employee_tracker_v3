require 'active_record'
require './lib/employee'
require './lib/division'
require './lib/project'
require './lib/contribution'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the Employee Tracker!"
  menu
end

def menu
  choice = nil
  until choice == 'e'
    puts "Press 'a' to add an employee, 'l' to list your employees"
    puts "Press 'd' to list divisions."
    puts "Press 'f' to list employees by division."
    puts "Press 'p' to add a project"
    puts "Press 'q' to see all projects for an employee"
    puts "Press 'c' to add a contribution to a project"
    puts "Press 'b' to see all contributions by an employee by project"
    puts "Press 'x' to see all projects in a division"
    puts "Press 'v' to see projects worked on within a date range"
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'a'
      add_employee
    when 'l'
      list_employee
    when 'e'
      puts "Good-bye!"
    when 'd'
      list_divisions
    when 'p'
      add_project
    when 'f'
      list_employees_by_division
    when 'q'
      list_projects_by_employee
    when 'b'
      list_contributions_by_employee
    when 'c'
      add_contribution
    when 'x'
      list_projects_by_division
    when 'v'
      projects_within_date
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end

def add_employee
  list_divisions
  puts "What's the employee's division?"
  input = gets.chomp
  division = Division.find_or_create_by({:name => input})
  puts "What is the employee's name?"
  employee_name = gets.chomp
  division.employees.new({:name => employee_name})
  division.save
  puts "'#{employee_name}' has been added to your tracker."
end

def list_employee
  puts "Here are all the employees:"
  employees = Employee.all
  employees.each { |employee| puts employee.name }
end

def list_divisions
  puts "Here are all the divisions:"
  divisions = Division.all
  divisions.each { |division| puts division.name }
end

def list_employees_by_division
  list_divisions
  puts "Which division?"
  input = gets.chomp
  division = Division.find_by(:name => input)
  division.employees.each { |employee| puts employee.name }
end

def add_project
  list_employee
  puts "Which employee would you like to add a project to?"
  input = gets.chomp
  employee = Employee.find_by(:name => input)
  puts "what is the name of the project?"
  name_input = gets.chomp
  puts "What is the start date for the project?"
  start_input = gets.chomp
  puts "What is the end date for the project?"
  end_input = gets.chomp
  project = Project.find_or_create_by(:name => name_input, :start_date => start_input, :end_date => end_input)
  contribution = Contribution.create(:employee_id => employee.id, :project_id => project.id)
  employee.projects << project
  puts "'#{project.name}' has been added"
end

def list_projects_by_employee
  list_employee
  puts "Which employee would you like to add a project to?"
  input = gets.chomp
  employee = Employee.find_by(:name => input)
  employee.projects.each { |project| puts project.name }
end

def add_contribution
  list_employee
  puts "Which employee?"
  employee_input = gets.chomp
  employee = Employee.find_by(:name => employee_input)
  puts "Which project did the employee contribute to?"
  employee.projects.each { |project| puts project.name }
  project_input = gets.chomp
  project = Project.find_by(:name => project_input)
  puts "What is the description of the contribution?"
  description_input = gets.chomp
  puts "When was the contribution made? YYYY-MM-DD "
  date_input = gets.chomp
  contribution = Contribution.create(:description => description_input, :employee_id => employee.id, :project_id => project.id, :date => date_input)
  employee.contributions << contribution
  puts "'#{contribution.description}' has been added!"
end

def list_contributions_by_employee
  list_employee
  puts "Which employee?"
  employee_input = gets.chomp
  employee = Employee.find_by(:name => employee_input)
  employee.contributions.each { |contribution| puts contribution.description }
end

def list_projects_by_division
  list_divisions
  puts "Which division?"
  division_input = gets.chomp
  division = Division.find_by(:name => division_input)
  division.projects.each {|project| puts project.name}
end

def projects_within_date
  list_employee
  puts "Which employee?"
  employee_input = gets.chomp
  employee = Employee.find_by(:name => employee_input)
  puts "What date range would you like to see the productivity for? enter start date YYYY-MM-DD"
  start_date_range = gets.chomp
  puts "Enter end date YYYY-MM-DD"
  end_date_range = gets.chomp
  employee.contributions.where(:date => start_date_range..end_date_range).each { |contribution| puts contribution.description }
end
welcome
