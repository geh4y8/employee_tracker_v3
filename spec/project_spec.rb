require 'spec_helper'

describe Project do
  it "belongs to an employee" do
    employee = Employee.create({:name => "Bob"})
    project = Project.create({:name => "Hire People", :start_date => "2012-03-20", :end_date => "2014-09-01"})
    contribution = Contribution.create({:description => "hired somebody", :project_id => project.id, :employee_id => employee.id})
    expect(project.employees).to eq [employee]
  end
end
