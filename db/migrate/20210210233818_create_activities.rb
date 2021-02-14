class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.float :weight, null: false
      t.datetime :date, null: false
      t.integer :time, null: false
      t.float :kcal, null: false
      t.float :distance, null: false

      t.timestamps
    end
  end
end
