require 'spec_helper'

describe Contribution do
  it 'adds a description to a contribution' do
    employee = Employee.create({:name => "Bob"})
    project = Project.create({:name => "Hire People"})
    description = "hired somebody"
    date = '2014-08-12'
    contribution = Contribution.create({:description => "hired somebody", :employee_id => employee.id, :project_id => project.id, :date => '2014-08-12'})
    expect(contribution.date).to eq date
  end
end
