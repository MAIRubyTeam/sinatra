class CreateAnalysis < ActiveRecord::Migration
  def change
    create_table :analysis do |t|
      t.string :observation
      t.string :result
    end
  end
end
