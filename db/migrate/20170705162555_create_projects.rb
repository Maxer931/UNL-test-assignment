class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: ''
      t.string :summary, null: false, default: ''
      t.string :start_date, null: false, default: '01/01/2000'
      t.string :end_date, null: false, default: '01/01/2000'
      t.timestamps
    end
  end
end
