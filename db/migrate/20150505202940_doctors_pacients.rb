class DoctorsPacients < ActiveRecord::Migration
  def change
  	create_table :doctors_pacients do |t|
  		t.references :doctor
  		t.references :pacient
  	end
  end
end
