class PacientsDoctors < ActiveRecord::Migration
  def change
  	create_table :pacients_doctors do |t|
  		t.references :doctor
  		t.references :pacient
  	end
  end
end