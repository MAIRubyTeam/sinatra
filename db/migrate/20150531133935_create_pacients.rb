class CreatePacients < ActiveRecord::Migration
  def change
  	create_table :pacients do |t|
      t.string :analysis_name, null: false
      t.datetime :analysis_date
    end
  end
end
