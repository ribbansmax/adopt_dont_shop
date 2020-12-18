class AddApprovedToAdoptions < ActiveRecord::Migration[5.2]
  def change
    add_column :adoptions, :approved, :boolean
  end
end
