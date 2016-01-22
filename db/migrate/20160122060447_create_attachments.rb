class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file, null: false
      t.belongs_to :task, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
