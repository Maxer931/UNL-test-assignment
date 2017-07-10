class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :status, null: false, default: ''
      t.integer :project_id
      t.integer :user_id
      t.timestamps
    end
  end
end
