class AddDescriptionToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :description, :string
  end
end
