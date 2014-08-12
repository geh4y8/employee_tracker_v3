require 'spec_helper'

describe Division do
  it "has many employees" do
    division = Division.create({:name => "division"})
    employee1 = Employee.create({:name => "employee1", :division_id => division.id})
    employee2 = Employee.create({:name => "employee2", :division_id => division.id})
    expect(division.employees).to eq [employee1, employee2]
  end

  it 'lists all projects that employees have worked on in a division' do
    division = Division.create({:name => "division"})
    employee = Employee.create({:name => "employee1", :division_id => division.id})
    employee2 = Employee.create({:name => "employee2", :division_id => division.id})
    project = Project.create(:name => "projectName")
    project2 = Project.create(:name => "projectName2")
    contribution = Contribution.create(:employee_id => employee.id, :project_id => project.id)
    contribution = Contribution.create(:employee_id => employee2.id, :project_id => project2.id)
    expect(division.projects).to eq [project, project2]
  end
end
