class CreatePost3 < ActiveRecord::Migration
  def change
    create_table :post3 do |t|
      t.string :name, null: false
      t.index :name, unique: true
    end
  end
end
