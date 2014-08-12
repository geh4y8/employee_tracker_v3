class AddTimesColumnToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :date, :datetime
  end
end
