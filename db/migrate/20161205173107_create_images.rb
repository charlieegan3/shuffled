class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :seed
      t.string :result

      t.timestamps
    end
  end
end
