class AddStartingYearToEducation < ActiveRecord::Migration[5.2]
  def change
    add_column :educations, :starting_year, :string
  end
end
