class ChangeStreetAddressToAddressInApplications < ActiveRecord::Migration[5.2]
  def change
    rename_column :applications, :street_address, :address
  end
end
