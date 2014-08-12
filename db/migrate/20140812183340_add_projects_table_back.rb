class AddProjectsTableBack < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.column :name, :string
      t.column :employee_id, :integer
    end
  end
end
