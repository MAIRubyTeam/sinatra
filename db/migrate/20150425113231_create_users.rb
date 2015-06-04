class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
	  t.string :name, null: false, :limit =>30
      t.index :name, unique: true
    end
  end
end
