class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :name, null: false
      t.text :description, null: false
      t.integer :state, null: false, default: 0

      t.belongs_to :user, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end
