class RenameNationalityColumnToCountryOfResidence < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :nationality, :country_of_residence
  end
end
