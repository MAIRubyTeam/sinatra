class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
    	t.string :pacient_policy
    	t.string :pacient_name
    end
  end
end