class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.belongs_to :project
      t.belongs_to :employee
    end
  end
end
