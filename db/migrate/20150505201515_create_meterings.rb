class CreateMeterings < ActiveRecord::Migration
  def change
    create_table :meterings do |t|
      t.integer :result
    end
  end
end
